require 'test_helper'

describe ReservationService do

  let(:user)  { users(:first_user) }
  let(:shape) { show.room.room_shape }

  let(:service) { ReservationService.new(user, show) }

  describe "with a numbered_seats show" do
    let(:show)  { reservations(:reservation_1).show }

    it "succeeds when the seats are available" do
      response = service.call seats: %w[a-2 b-2]

      response.must_be :successful?
      response.reservation.must_be :persisted?
    end

    it "fails when seats dont exist" do
      lambda do
        service.call seats: shape.void_places.take(1)
      end.must_raise ReservationService::InvalidSeats
    end

    it "fails when seat is already occupied" do
      response = service.call seats: reservations(:reservation_1).seats.map(&:code)

      response.wont_be :successful?
      response.errors[:seats].wont_be_empty
    end

  end

  describe "with an unnumbered_seats show" do
    let(:show)  { shows(:Show_2) }

    it "succeeds when the seats are available" do
      response = service.call seats_count: 2

      response.must_be :successful?
      response.reservation.must_be :persisted?
    end

    it "fails when seat is already occupied" do
      response = service.call seats_count: 100

      response.wont_be :successful?
      response.errors[:seats_count].wont_be_empty
    end

  end


end
