require 'service_response'

class PurchaseService
  InvalidSeats = ArgumentError

  def initialize(user, show)
    @user = user
    @show = show
  end

  def call(purchase_attributes)
    card_number            = purchase_attributes[:card_number]
    card_verification_code = purchase_attributes[:card_verification_code]
    card_owner_name        = purchase_attributes[:card_owner_name]

    credit_card = PaymentGateway::CreditCard.new(card_number, card_verification_code, card_owner_name)

    if @show.numbered_seats?
      seats       = validate_seats! purchase_attributes.fetch(:seats)
      seats_count = seats.size
    else
      seats_count = purchase_attributes.fetch(:seats_count).to_i
      seats       = select_seats seats_count
    end

    new_purchase = Purchase.new(user: @user, show: @show) do |purchase|
      if purchase_attributes[:promotion_id].present?
        purchase.promotion_code = purchase_attributes[:promotion_code]
        purchase.card_number    = card_number
        purchase.promotion      = @show.promotions.find(purchase_attributes[:promotion_id])
      end
      purchase.kids_count = purchase_attributes.fetch(:kids_count, 0)

      purchase.total_cents = PriceSetting.total_price_for(purchase)

      seats.each do |place|
        purchase.seats.build(code: place, status: Seat::STATUS_RESERVED, taken_by: @user, show: @show)
      end
    end

    if new_purchase.valid?
      charge   = PaymentGateway.charge(credit_card, new_purchase.total_cents)
      new_purchase.payment_token  = charge.transaction_id
      new_purchase.payment_status = charge.status
    end

    new_purchase.save

    PurchaseResponse.new(new_purchase)
  end

  private

  def validate_seats!(places)
    places.all? do |place|
      @show.room_shape.has_place? place
    end or raise InvalidSeats
    places
  end

  def select_seats(count)
    @show.available_places.take(count)
  end

  class PurchaseResponse < ServiceResponse::Entity
    alias :purchase :entity
  end

end
