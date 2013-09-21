class Show < ActiveRecord::Base
  belongs_to :movie
  belongs_to :room

  validates_presence_of :movie
  validates_presence_of :room
  validates_presence_of :starts_at

end
