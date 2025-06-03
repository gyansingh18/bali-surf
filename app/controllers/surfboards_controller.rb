class SurfboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @surfboards = Surfboard.all
  end
end
