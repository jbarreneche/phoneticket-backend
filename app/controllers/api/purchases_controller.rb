class Api::PurchasesController < Api::BaseController
  # before_filter :ensure_user

  def create
    response = if params[:reservation_id]
      purchase_from_reservation
    else
      purchase_from_scratch
    end

    if response.successful?
      render response.purchase
    else
      @purchase = response.purchase

      render 'purchase_with_errors', status: :unprocessable_entity
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

  def purchase_from_reservation
    reservation = Reservation.find(params[:reservation_id])

    service = purchase_reservation_service(reservation)

    service.call allowed_purchase_params
  end

  def purchase_from_scratch
    ensure_user

    show = Show.lock.find(params[:show_id])

    service = purchase_service(show)

    service.call allowed_purchase_params
  end

  def allowed_purchase_params
    params.permit(:seats_count,
      :promotion_id, :promotion_code, :bank_card_number,
      :card_number, :card_verification_code, :card_owner_name,
      seats: []
    )
  end

  def purchase_reservation_service(reservation)
    PurchaseReservationService.new(reservation)
  end

  def purchase_service(show)
    PurchaseService.new(current_user, show)
  end

end
