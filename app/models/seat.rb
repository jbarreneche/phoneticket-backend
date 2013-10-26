class Seat < ActiveRecord::Base
  belongs_to :show
  belongs_to :taken_by, polymorphic: true

  validates_uniqueness_of :code, scope: :show_id

  STATUSES =
    (STATUS_RESERVED, STATUS_PURCHASED = %w[reserved purchased])

  def to_s
    code
  end

  def to_place
    code.split('-')
  end

end
