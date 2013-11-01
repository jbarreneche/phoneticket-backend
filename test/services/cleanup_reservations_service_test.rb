require 'test_helper'

describe CleanupReservationsService do

  let(:reservation)  { reservations(:reservation_1) }
  let(:show) { shows(:Show_1) }

  it "doesnt cancel reservations when they are way in the future" do
    CleanupReservationsService.new.call

    reservation.status.wont_equal "canceled"
  end

  it "cancels reservation if its within an hour of now" do
    now = show.starts_at - 59.minutes
    CleanupReservationsService.new(now).call

    reservation.reload.status.must_equal "canceled"
  end

end
