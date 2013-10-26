require 'service_response'

class ReservationService
  InvalidSeats = ArgumentError
  NotEnoughEmptySeats = ArgumentError

  def initialize(user, show)
    @user = user
    @show = show
  end

  def call(options)
    if @show.numbered_seats
      seats       = validate_seats! options.fetch(:seats)
      seats_count = seats.size
    else
      seats_count = options.fetch(:seats_count)
      seats       = select_seats seats_count
    end

    reservation = Reservation.new(user: @user, show: @show) do |res|

      if options[:promotion_id].present?
        res.promotion_code   = options[:promotion_code]
        res.bank_card_number = options[:bank_card_number]
        res.promotion  = @show.promotions.find(options[:promotion_id])
      end
      res.kids_count = options.fetch(:kids_count, 0)

      seats.each do |place|
        res.seats.build(code: place, status: Seat::STATUS_RESERVED, taken_by: @user, show: @show)
      end
    end

    if seats.size == seats_count
      reservation.save
    else
      reservation.errors.add(:seats_count, "No hay suficientes asientos disponibles")
    end

    ReservationResponse.new(reservation)
  end

  def validate_seats!(places)
    places.all? do |place|
      @show.room_shape.has_place? place
    end or raise InvalidSeats
    places
  end

  def select_seats(count)
    @show.available_places.take(count)
  end

  class ReservationResponse < ServiceResponse::Entity
    alias :reservation :entity
  end

end
