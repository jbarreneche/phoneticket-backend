class Reservation < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
  belongs_to :purchase
  has_many :seats, as: :taken_by
end
