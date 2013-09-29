class Seat < ActiveRecord::Base
  belongs_to :show
  belongs_to :taken_by, polymorphic: true

  STATUSES =
    (STATUS_RESERVED, STATUS_PURCHASED = %w[reserved purchased])

end
