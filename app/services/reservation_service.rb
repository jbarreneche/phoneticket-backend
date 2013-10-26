require 'service_response'

class ReservationService
  InvalidSeats = ArgumentError

  def initialize(user, show)
    @user = user
    @show = show
  end

  def call(options)
    places = validate_places! options.fetch(:seats)

    reservation = Reservation.create(user: @user, show: @show) do |res|
      places.each do |place|
        res.seats.build(code: place, status: Seat::STATUS_RESERVED, taken_by: @user, show: @show)
      end
    end

    ReservationResponse.new(reservation)

  end

  def validate_places!(places)
    places.all? do |place|
      @show.room_shape.has_place? place
    end or raise InvalidSeats
    places
  end


  class ReservationResponse < ServiceResponse::Entity
    alias :reservation :entity
  end

end
