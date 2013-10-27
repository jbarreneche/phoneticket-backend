class Api::PurchasesController < Api::BaseController
  # before_filter :ensure_user

  def create
    if params[:reservation_id]
      purchase_from_reservation
    else
      # purchase_from_scratch
    end
  end

  private

  def purchase_from_reservation
    reservation = Reservation.find(params[:reservation_id])

    service = purchase_reservation_service(reservation)

    response = service.call allowed_payment_params

    if response.successful?
      render response.purchase
    else
      @purchase = response.purchase

      render 'purchase_with_errors', status: :unprocessable_entity
    end
  end

  private

  def allowed_payment_params
    params.permit(:card_number, :card_verification_code, :card_owner_name)
  end

  def purchase_reservation_service(reservation)
    PurchaseReservationService.new(reservation)
  end

end
