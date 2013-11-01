class Reservation < ActiveRecord::Base
  belongs_to :show, touch: true
  belongs_to :user
  has_one :purchase, inverse_of: :reservation
  has_many :seats, as: :taken_by

  scope :not_canceled, -> { where.not(status: STATUS_CANCELED) }
  scope :not_purchased, -> { where.not(status: STATUS_COMPLETED) }
  scope :pending, -> { where(status: STATUS_PENDING) }
  scope :still_not_finished, ->(date = Date.current) { pending.joins(:show).references(:show).where(["shows.starts_at > ?", date]) }
  scope :with_show_before, ->(now = Time.current) { joins(:show).includes(:show).merge(Show.inactive(now)) }

  validate :on_time_for_show, on: :create

  STATUSES =
    (STATUS_PENDING, STATUS_CANCELED, STATUS_COMPLETED = %w[pending canceled completed])

  # Change reservation status and clear seats
  def cancel!
    transaction do
      update_attributes!(status: STATUS_CANCELED)
      seats.destroy_all
    end
  end

  def cancellable?
    status == STATUS_PENDING
  end

  private

  def on_time_for_show
    errors.add(:show_id, :reservation_time_expired) unless show.on_time_for_reservation?
  end

end
