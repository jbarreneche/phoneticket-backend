class Show < ActiveRecord::Base
  belongs_to :movie
  belongs_to :room

  validates_presence_of :movie
  validates_presence_of :room
  validates_presence_of :starts_at

  scope :active, -> { where(["starts_at > ?", Time.current]) }

  def name
    "#{movie.title} - #{room.to_label}"
  end

end
