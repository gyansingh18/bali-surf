class SurfboardsController < ApplicationController

  def new
    @surfboard = Surfboard.new
  end

  def create
    @surfboard = Surfboard.new(surfboard_params)
    @surfboard.user = current_user
    if @surfboard.save
      # Change path later on
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def surfboard_params
    params.require(:surfboard).permit(:category, :size, :price, :tail, :location, :image_url)
  end
end
