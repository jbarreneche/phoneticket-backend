require 'service_response'

class PurchaseReservationService
  InvalidSeats = ArgumentError

  def initialize(reservation)
    @reservation = reservation
    @show = @reservation.show
  end

  def call(purchase_attributes)
    card_number            = purchase_attributes[:card_number]
    card_verification_code = purchase_attributes[:card_verification_code]
    card_owner_name        = purchase_attributes[:card_owner_name]

    credit_card = PaymentGateway::CreditCard.new(card_number, card_verification_code, card_owner_name)

    purchase = Purchase.from_reservation(@reservation)

    if purchase_attributes[:promotion_id].present?
      purchase.promotion_code = purchase_attributes[:promotion_code]
      purchase.card_number    = card_number
      purchase.promotion      = @show.promotions.find(purchase_attributes[:promotion_id])
    end
    purchase.kids_count = purchase_attributes.fetch(:kids_count, 0)

    purchase.total_cents = PriceSetting.total_price_for(purchase)

    if purchase.valid?
      charge   = PaymentGateway.charge(credit_card, purchase.total_cents)
      purchase.payment_token  = charge.transaction_id
      purchase.payment_status = charge.status
    end

    purchase.save

    PurchaseResponse.new(purchase)
  end

  class PurchaseResponse < ServiceResponse::Entity
    alias :purchase :entity
  end

end
