class RoomStatus

  def initialize(room, seats)
    @room = room
    @taken_seats = seats.group(:status).count()
  end

  def available_seats_count
    @room.total_seats - reserved_seats - purchased_seats
  end

  def reserved_seats
    @taken_seats.fetch(Seat::STATUS_RESERVED, 0)
  end

  def purchased_seats
    @taken_seats.fetch(Seat::STATUS_PURCHASED, 0)
  end

end
