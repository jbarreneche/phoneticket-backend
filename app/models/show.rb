class Show < ActiveRecord::Base
  belongs_to :movie
  belongs_to :room
  has_many :seats, dependent: :restrict_with_error

  validates_presence_of :movie
  validates_presence_of :room
  validates_presence_of :starts_at

  delegate :available_seats_count, :reserved_seats, :purchased_seats, to: :room_status
  delegate :room_shape, to: :room

  scope :active, -> { where(["starts_at > ?", Time.current]) }

  def name
    "#{movie.title} - #{room.to_label}"
  end

  def room_status
    @room_status ||= RoomStatus.new(room, self.seats)
  end

  def available_places
    room_shape.places - taken_places
  end

  def taken_places
    seats.map(&:code)
  end

end
