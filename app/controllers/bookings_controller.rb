class BookingsController < ApplicationController
  def index
    # @bookings = Booking.all
    @bookings_as_owner = current_user.surfboards.map do |surfboard|
      surfboard.bookings
    end

    @bookings_as_owner = @bookings_as_owner.flatten

    @bookings_as_renter = current_user.bookings
    # raise/
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
    redirect_to bookings_path
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.update(status: "accepted")
    redirect_to bookings_path, notice: "Booking accepted."
  end

  def deny
    @booking = Booking.find(params[:id])
    @booking = Booking.update(status: "denied")
    redirect_to bookings_path, alert: "Booking denied."
  end


  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
