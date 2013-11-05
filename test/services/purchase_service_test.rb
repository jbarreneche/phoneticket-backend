require 'test_helper'

describe PurchaseReservationService do

  let(:user)  { users(:first_user) }
  let(:shape) { show.room.room_shape }
  let(:reservation)  { reservations(:reservation_1) }
  let(:service) { PurchaseService.new(user, show) }
  let(:valid_payment_information) do
    {
      card_owner_name: "CARLOS FONTELA",
      card_number: "1111111111111111",
      card_verification_code: "111"
    }
  end

  describe "with a numbered_seats show" do
    let(:show)  { reservations(:reservation_1).show }

    it "succeeds when the seats are available" do
      response = service.call valid_payment_information.merge(seats: %w[a-2 b-2])

      response.must_be :successful?
      response.purchase.must_be :persisted?
    end

    it "sets seats as reserved" do
      response = service.call seats: %w[a-2 b-2]

      response.must_be :successful?
      response.purchase.seats.each do |seat|
        seat.status.must_equal Seat::STATUS_PURCHASED
      end
    end

    it "fails when seats dont exist" do
      lambda do
        service.call valid_payment_information.merge(seats: shape.void_places.take(1))
      end.must_raise PurchaseService::InvalidSeats
    end

    it "fails when seat is already occupied" do
      response = service.call valid_payment_information.merge(seats: reservations(:reservation_1).seats.map(&:code))

      response.wont_be :successful?
      response.errors[:seats].wont_be_empty
    end

    it "fails when the payment information is invalid" do
      response = service.call valid_payment_information.merge(
        card_number: "9999999999999999", seats: %w[a-2 b-2]
      )

      response.wont_be :successful?
      response.purchase.errors[:payment].wont_be_empty
    end

  end

  describe "with a numbered_seats show" do
    let(:show)  { shows(:Show_2) }

    it "succeeds when the seats are available" do
      response = service.call valid_payment_information.merge(seats_count: 2)

      response.must_be :successful?
      response.purchase.must_be :persisted?
    end

    it "fails when seat is already occupied" do
      response = service.call valid_payment_information.merge(seats_count: 100)

      response.wont_be :successful?
      response.errors[:seats_count].wont_be_empty
    end
  end

  describe "using promotions" do
    let(:show)  { shows(:Show_2) }
    let(:code_promotion) { promotions(:code) }
    let(:bank_promotion) { promotions(:bank) }
    let(:valid_purchase_params) { valid_payment_information.merge(seats_count: 2) }

    it "fails with an invalid promotion code" do
      response = service.call valid_purchase_params.merge(
        promotion_id: code_promotion.id, promotion_code: "invalid"
      )

      response.wont_be :successful?
      response.errors[:promotion_code].wont_be_empty
    end

    it "doesnt process payment when the promotion is invalid" do
      response = service.call valid_purchase_params.merge(
        promotion_id: code_promotion.id, promotion_code: "invalid"
      )

      response.wont_be :successful?
      response.purchase.payment_status.must_be_nil
    end

    it "succeeds with an valid promotion code" do
      response = service.call valid_purchase_params.merge(
        promotion_id: code_promotion.id, promotion_code: "some-code"
      )

      response.must_be :successful?
      response.purchase.must_be :persisted?
    end

    it "fails with an invalid bank card number" do
      response = service.call valid_purchase_params.merge(
        promotion_id: bank_promotion.id, card_number: "9invalid"
      )

      response.wont_be :successful?
      response.errors[:card_number].wont_be_empty
    end

    it "succeeds with an valid bank card number" do
      response = service.call valid_purchase_params.merge(
        promotion_id: bank_promotion.id, card_number: "valid"
      )

      response.must_be :successful?
      response.purchase.must_be :persisted?
      response.purchase.promotion.wont_be_nil
    end

  end

  describe "After the show started" do
    let(:show)  { shows(:ExpiringShow) }

    it "fails to take purchases" do
      show.starts_at = 1.second.ago
      response = service.call valid_payment_information.merge(seats_count: 1)

      response.wont_be :successful?
      response.errors[:show_id].wont_be_empty
    end

  end

end
