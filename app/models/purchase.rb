class Purchase < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
  has_many :seats, as: :taken_by

  scope :still_not_finished, ->(date = Date.current) { joins(:show).references(:show).where(["shows.starts_at > ?", date]) }

end
