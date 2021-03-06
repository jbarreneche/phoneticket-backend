class Show < ActiveRecord::Base
  belongs_to :movie
  belongs_to :room
  has_many :seats, dependent: :restrict_with_error

  validates_presence_of :movie
  validates_presence_of :room
  validates_presence_of :starts_at

  delegate :available_seats_count, :reserved_seats_count, :purchased_seats_count, to: :room_status
  delegate :room_shape, to: :room

  scope :active,   ->(now = Time.current) { where(["starts_at > ?", now]) }
  scope :inactive, ->(now = Time.current) { where(["starts_at < ?", now]) }

  def name
    "#{movie.title} - #{room.to_label}"
  end

  def room_status
    @room_status ||= RoomStatus.new(room, self.seats)
  end

  def promotions
    Promotion.all
  end

  def available_places
    room_shape.places - taken_places
  end

  def on_time_for_reservation?
    (starts_at - 1.hour).future?
  end

  def taken_places
    seats.map(&:code)
  end

  def prices
    movie.prices_for(starts_at.to_date)
  end

  def promotions
    Promotion.enabled_for_show(self)
  end

end
