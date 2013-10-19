class ReservationsController < ApplicationController
  respond_to :html

  def show
    @reservation = Reservation.not_canceled.find(params[:id])
    respond_with @reservation
  end

end
