require 'service_response'

class PurchaseReservationService
  InvalidSeats = ArgumentError

  def initialize(reservation)
    @reservation = reservation
  end

  def call(payment_information)
    card_number            = payment_information[:card_number]
    card_verification_code = payment_information[:card_verification_code]
    card_owner_name        = payment_information[:card_owner_name]

    credit_card = PaymentGateway::CreditCard.new(card_number, card_verification_code, card_owner_name)

    purchase = Purchase.from_reservation(@reservation)
    purchase.total_cents = PriceSetting.total_price_for(purchase)

    charge   = PaymentGateway.charge(credit_card, purchase.total_cents)
    purchase.payment_token  = charge.transaction_id
    purchase.payment_status = charge.status

    purchase.save

    PurchaseResponse.new(purchase)
  end

  class PurchaseResponse < ServiceResponse::Entity
    alias :purchase :entity
  end

end
