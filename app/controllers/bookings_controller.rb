class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @surfboard = Surfboard.find(params[:surfboard_id])
    @booking = Booking.new()
  end

  def create
    @booking = Booking.new(booking_params)
    @surfboard = Surfboard.find(params[:surfboard_id])
    @booking.user = current_user
    @booking.surfboard = @surfboard
    @booking.total_price = ((@booking.end_date - @booking.start_date).to_i + 1) * @surfboard.price
    @booking.save
    redirect_to surfboard_bookings_path
  end

  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
