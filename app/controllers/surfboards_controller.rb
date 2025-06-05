class SurfboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @surfboards = Surfboard.all
    if params[:location].present?
      @surfboards = @surfboards.near(params[:location], 5)
      # Surfboard.near("#{params[:location]}", 10)
    end
    if params[:surfboard].present?
      if params[:surfboard][:category].present?
        @surfboards = @surfboards.where("category ILIKE ?", "%#{params[:surfboard][:category]}%")
      end
      if params[:surfboard][:tail].present?
        @surfboards = @surfboards.where("tail ILIKE ?", "%#{params[:surfboard][:tail]}%")
      end
      if @surfboards.empty?
        flash.now[:alert] = "Sorry, no boards match your research"
        @surfboards = Surfboard.all
      end
    end
    @markers = @surfboards.geocoded.map do |surfboard|
      {
        lat: surfboard.latitude,
        lng: surfboard.longitude
      }
    end
  end

  def new
    @surfboard = Surfboard.new
  end

  def create
    @surfboard = Surfboard.new(surfboard_params)
    @surfboard.user = current_user
    if @surfboard.save
      # Change path later on
      redirect_to surfboards_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def surfboard_params
    params.require(:surfboard).permit(:category, :size, :price, :tail, :location, :image_url, :photo)
  end
end
