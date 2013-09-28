class Purchase < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
  has_many :seats, as: :taken_by
end
