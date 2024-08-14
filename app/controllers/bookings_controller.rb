class BookingsController < ApplicationController

  def index
    @bookings = current_user.bookings
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.vehicule = Vehicule.find(params[:vehicule_id])
    @booking.status = 'Pending'
    if @booking.save
      redirect_to vehicules_path, notice: 'Votre demande de réservation a bien été envoyée'
    else
      render :new, status: :unprocessable_entity, locals: { booking: @booking }
    end
  end

  # def destroy
  #   @booking = Booking.find(params[:id])
  #   @booking.destroy
  #   redirect_to user_bookings_path(@booking.user), notice: 'Booking was successfully canceled.'
  # end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
