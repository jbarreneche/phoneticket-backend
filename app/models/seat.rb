class Seat < ActiveRecord::Base
  belongs_to :show
  belongs_to :taken_by, polymorphic: true

  scope :reserved, -> { where(status: STATUS_RESERVED) }
  scope :purchased, -> { where(status: STATUS_PURCHASED) }

  STATUSES =
    (STATUS_RESERVED, STATUS_PURCHASED = %w[reserved purchased])

  def to_s
    code
  end

  def to_place
    code.split('-')
  end

end
