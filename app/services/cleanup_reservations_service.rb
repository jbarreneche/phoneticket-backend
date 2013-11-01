class CleanupReservationsService
  attr_reader :now

  def initialize(now = Time.now)
    @now = now
  end

  def call
    Reservation.pending.with_show_before((@now + 1.hour).to_s(:db)).each(&method(:cancel_reservation))
  end

  private

  def cancel_reservation(reservation)
    reservation.cancel!
  rescue => e
    Rails.logger.error(e)
  end

end
