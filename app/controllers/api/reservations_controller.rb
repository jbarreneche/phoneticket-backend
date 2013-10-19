class Api::ReservationsController < Api::BaseController

  def destroy
    @reservation = Reservation.find params[:id]

    @reservation.cancel!

    head :ok
  end

end
