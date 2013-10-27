class Purchase < ActiveRecord::Base
  belongs_to :show, touch: true
  belongs_to :user
  belongs_to :reservation, autosave: true, inverse_of: :purchase
  has_many :seats, as: :taken_by

  scope :still_not_finished, ->(date = Date.current) { joins(:show).references(:show).where(["shows.starts_at > ?", date]) }

  validate :payment_status_not_rejected

  def self.from_reservation(reservation)
    new do |purchase|
      reservation.status = Reservation::STATUS_COMPLETED
      purchase.reservation = reservation
      purchase.show = reservation.show
      purchase.user = reservation.user
      purchase.seats = reservation.seats
      purchase.seats.each do |seat|
        seat.status = Seat::STATUS_PURCHASED
      end
    end
  end

  private

  def payment_status_not_rejected
    errors.add(:payment, "Pago rechazado") if payment_status == "rejected"
  end

end
