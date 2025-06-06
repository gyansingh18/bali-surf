class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @surfboards = Surfboard.all
    @markers = @surfboards.geocoded.map do |surfboard|
      {
        lat: surfboard.latitude,
        lng: surfboard.longitude,
        info_window_html: render_to_string(partial: "surfboards/info_window", locals: { surfboard: surfboard }),
        marker_html: render_to_string(partial: "surfboards/marker")
      }
    end
  end
end
