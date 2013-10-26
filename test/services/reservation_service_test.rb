require 'test_helper'

class ReservationServiceTest < ActiveSupport::TestCase

  let(:user)  { users(:first_user) }
  let(:show)  { reservations(:reservation_1).show }
  let(:shape) { show.room.room_shape }

  let(:service) { ReservationService.new(user, show) }

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
    response.reservation.wont_be :persisted?
    response.wont_be :successful?
    response.errors.wont_be_empty
  end

end
