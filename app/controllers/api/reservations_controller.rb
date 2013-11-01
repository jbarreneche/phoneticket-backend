class Api::ReservationsController < Api::BaseController
  before_filter :ensure_user, only: :create

  def destroy
    @reservation = Reservation.find params[:id]

    @reservation.cancel!

    render json: {}
  end

  def create
    show = Show.lock.find(params[:show_id])

    service = reservation_service(show)

    response = service.call allowed_reservation_params

    if response.successful?
      render response.reservation
    else
      @reservation = response.reservation

      render 'reservation_with_errors', status: :unprocessable_entity
    end

  rescue ReservationService::InvalidSeats
    # XXX: Decide if should improve
    render json: {
      errors: {
        seats: ["Alguno de los asientos enviados no existe"]
      }
    }, status: :bad_request
  end

  private

  def allowed_reservation_params
    params.permit(:seats_count, seats: [])
  end

  def reservation_service(show)
    ReservationService.new(current_user, show)
  end

end
