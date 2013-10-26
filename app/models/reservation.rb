class Reservation < ActiveRecord::Base
  belongs_to :show, touch: true
  belongs_to :user
  belongs_to :purchase
  has_many :seats, as: :taken_by

  scope :not_canceled, -> { where.not(status: STATUS_CANCELED) }
  scope :pending, -> { where(status: STATUS_PENDING) }
  scope :still_not_finished, ->(date = Date.current) { pending.joins(:show).references(:show).where(["shows.starts_at > ?", date]) }

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

end
