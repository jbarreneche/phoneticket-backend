class Purchase < ActiveRecord::Base
  belongs_to :show, touch: true
  belongs_to :user
  belongs_to :reservation, autosave: true, inverse_of: :purchase
  belongs_to :promotion
  has_many :seats, as: :taken_by

  scope :still_not_finished, ->(date = Date.current) { joins(:show).references(:show).where(["shows.starts_at > ?", date]) }

  validate :payment_status_not_rejected
  validate :check_promotion
  validate :show_hasnt_started

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

  def check_promotion
    promotion.validate(self) if promotion.present?
  end

  def show_hasnt_started
    errors.add(:show_id, :purchase_time_expired) unless show.starts_at.future?
  end
end
