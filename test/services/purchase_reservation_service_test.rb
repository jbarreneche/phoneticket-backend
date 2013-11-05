require 'test_helper'

describe PurchaseReservationService do

  let(:reservation)  { reservations(:reservation_1) }
  let(:service) { PurchaseReservationService.new(reservation) }
  let(:valid_payment_information) do
    {
      card_owner_name: "CARLOS FONTELA",
      card_number: "1111111111111111",
      card_verification_code: "111"
    }
  end

  it "creates a purchase with the same information" do
    seat_codes = reservation.seats.map(&:code)

    response = service.call valid_payment_information
    purchase = response.purchase

    response.must_be :successful?
    purchase.must_be :persisted?
    purchase.seats.map(&:code).must_equal seat_codes
    purchase.user.must_equal reservation.user
    purchase.show.must_equal reservation.show
  end

  it "marks the reservation as completed and removes all seats" do
    response = service.call valid_payment_information

    response.must_be :successful?


    reservation.status.must_equal Reservation::STATUS_COMPLETED

    reservation.reload
    reservation.seats.must_be_empty
  end

  it "fails when the payment information is invalid" do
    response = service.call valid_payment_information.merge(card_number: "9999999999999999")

    response.wont_be :successful?
    response.purchase.errors[:payment].wont_be_empty
  end

  describe "using promotions" do
    let(:show)  { shows(:Show_2) }
    let(:code_promotion) { promotions(:code) }
    let(:bank_promotion) { promotions(:bank) }

    it "fails with an invalid promotion code" do
      response = service.call valid_payment_information.merge(
        promotion_id: code_promotion.id, promotion_code: "invalid"
      )

      response.wont_be :successful?
      response.errors[:promotion_code].wont_be_empty
    end

    it "doesnt process payment when the promotion is invalid" do
      response = service.call valid_payment_information.merge(
        promotion_id: code_promotion.id, promotion_code: "invalid"
      )

      response.wont_be :successful?
      response.purchase.payment_status.must_be_nil
    end

    it "succeeds with an valid promotion code" do
      response = service.call valid_payment_information.merge(
        promotion_id: code_promotion.id, promotion_code: "some-code"
      )

      response.must_be :successful?
      response.purchase.must_be :persisted?
    end

    it "fails with an invalid bank card number" do
      response = service.call valid_payment_information.merge(
        promotion_id: bank_promotion.id, card_number: "9invalid"
      )

      response.wont_be :successful?
      response.errors[:card_number].wont_be_empty
    end

    it "succeeds with an valid bank card number" do
      response = service.call valid_payment_information.merge(
        promotion_id: bank_promotion.id, card_number: "valid"
      )

      response.must_be :successful?
      response.purchase.must_be :persisted?
      response.purchase.promotion.wont_be_nil
    end

  end
end
