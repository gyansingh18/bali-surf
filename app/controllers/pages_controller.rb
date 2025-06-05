class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @surfboards = Surfboard.all
    @markers = @surfboards.geocoded.map do |surfboard|
      {
        lat: surfboard.latitude,
        lng: surfboard.longitude
      }
    end
  end
end
