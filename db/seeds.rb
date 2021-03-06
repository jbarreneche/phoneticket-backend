# encoding: UTF-8
price_std = PriceSetting.where(name: "Normal").first_or_initialize
price_std.assign_attributes adult: 30, kid: 15,
        discount_days: %w[wednesdays], adult_with_discount: 15, kid_with_discount: 10
price_std.save(validate: false)

price_3d = PriceSetting.where(name: "3D").first_or_initialize
price_3d.assign_attributes adult: 60, kid: 45,
        discount_days: [], adult_with_discount: nil, kid_with_discount: nil
price_3d.save(validate: false)

theatres = {
  "Cine 1" => {
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet quam tellus. Proin pellentesque risus ante, nec pulvinar nisl scelerisque sit amet. Aenean eu diam a odio tincidunt luctus sed in risus. Suspendisse euismod tristique arcu nec laoreet. Pellentesque sit amet tincidunt turpis, sed vehicula nunc. Praesent a nisl congue tortor molestie rutrum condimentum sit amet sem. Donec dignissim tempor velit, vulputate ultrices tellus sodales vel. Donec suscipit aliquet est, ut tristique nisl blandit non.",
    address: "Avenida Paseo Colón 850",
    latitude: -34.617811,
    longitude: -58.368222
  },
  "Cine 2" => {
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet quam tellus. Proin pellentesque risus ante, nec pulvinar nisl scelerisque sit amet. Aenean eu diam a odio tincidunt luctus sed in risus. Suspendisse euismod tristique arcu nec laoreet. Pellentesque sit amet tincidunt turpis, sed vehicula nunc. Praesent a nisl congue tortor molestie rutrum condimentum sit amet sem. Donec dignissim tempor velit, vulputate ultrices tellus sodales vel. Donec suscipit aliquet est, ut tristique nisl blandit non.",
    address: "Avenida Las Heras 2214",
    latitude: -34.588333,
    longitude: -58.396208
  },
  "Cine 3" => {
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet quam tellus. Proin pellentesque risus ante, nec pulvinar nisl scelerisque sit amet. Aenean eu diam a odio tincidunt luctus sed in risus. Suspendisse euismod tristique arcu nec laoreet. Pellentesque sit amet tincidunt turpis, sed vehicula nunc. Praesent a nisl congue tortor molestie rutrum condimentum sit amet sem. Donec dignissim tempor velit, vulputate ultrices tellus sodales vel. Donec suscipit aliquet est, ut tristique nisl blandit non.",
    address: "Avenida Córdoba 2122",
    latitude: -34.599709,
    longitude: -58.397981
  }
}
theatre_1, theatre_2, theatre_3 = theatres.map do |(name, attributes)|
  theatre = Theatre.where(name: name).first_or_initialize
  theatre.assign_attributes attributes
  theatre.save(validate: false)
  theatre
end

def calc_shape(number)
  number.even? ? "standard" : "small"
end

rooms = [theatre_1, theatre_2, theatre_3].flat_map do |theatre|
  room_1 = theatre.rooms.where(name: "Sala 1").first_or_initialize
  room_1.update_attributes(
    shape: calc_shape(theatre.id + 1)
  )
  room_2 = theatre.rooms.where(name: "Sala 2").first_or_initialize
  room_2.update_attributes(
    shape: calc_shape(theatre.id + 2)
  )
  [room_1, room_2]
end

matrix = Movie.where(title: "Matrix 3D").first_or_initialize
matrix.assign_attributes(
  youtube_trailer: "http://www.youtube.com/watch?v=m8e-FF8MsqU",
  director: "Hermanos Wachowski",
  cast: ["Keanu Reeves", "Laurence Fishburne"],
  country: "Estados Unidos",
  genre: "sci-fi",
  audience_rating: "PG-13",
  price_setting: price_3d,
  synopsis: <<-SYN.strip_heredoc
  ¿Es el mundo lo que parece? Thomas Anderson (Keanu Reeves), programador de una importante empresa de software y asaltador informático de alias Neo, averiguará que no. Con él contactará un extraño grupo encabezado por Morfeo (Lawrence Fishburne), quien le mostrará la verdadera realidad que se esconde tras lo aparente: un mundo dominado por las máquinas, las cuales esclavizan a la Humanidad para utilizar nuestros cuerpos como simple fuente de energía. ¿Pero, y nuestra mente, dónde se encuentra entonces? la respuesta está en Matrix.
  SYN
)
matrix.save(validate: false)

planes = Movie.where(title: "Aviones").first_or_initialize
planes.assign_attributes(
  youtube_trailer: "http://www.youtube.com/watch?v=YRjztG65XgI",
  director: "Klay Hall",
  cast: ["Val Kilmer", "Julia Louis-Dreyfus"],
  country: "Estados Unidos",
  genre: "animation",
  audience_rating: "ATP",
  price_setting: price_std,
  synopsis: <<-SYN.strip_heredoc
  Desde las alturas del mundo de “Cars” llega la película de Disney “Aviones”. La nueva película de animación en 3D llena de acción y aventuras, protagonizada por Dusty (voz de Dane Cook), un avión que sueña con participar en una competición aérea de altos vuelos. Pero Dusty no fue precisamente construido para competir y resulta que... ¡tiene miedo a las alturas! Así que, recurre a un experimentado aviador naval que le ayuda a clasificarse para retar al vigente campeón del circuito de carreras. Dusty demostrará su valor para alcanzar alturas inimaginables y enseñará al mundo lo que hay que hacer para levantar el vuelo. La película de Disney “Aviones” despega en agosto de 2013 y estará disponible en Disney Digital 3D™ en una selección de cines.
  SYN
)
planes.save(validate: false)

Movie.where(price_setting_id: nil).update_all(price_setting_id: price_std.id)

matrix_rooms = rooms[0...3]
planes_rooms = rooms[3...6]

thursday = Date.today.next_week(:thursday)

(matrix_rooms * 2).zip %w[19:00 20:30 21:00 21:30].cycle do |room, time|
  room.shows.where(starts_at: Time.zone.parse("#{thursday} #{time}"), movie: matrix).first_or_create!
end

(planes_rooms * 2).zip %w[16:30 19:00 22:30 23:15].cycle do |room, time|
  room.shows.where(starts_at: Time.zone.parse("#{thursday} #{time}"), movie: planes).first_or_create!
end

def generate_purchase(show, places)
  user     = User.first
  purchase = Purchase.new(user: user, show: show)

  places.each do |place|
    purchase.seats.build(code: place, status: Seat::STATUS_PURCHASED, taken_by: user, show: show)
  end
  purchase.save(validate: false)
end

def generate_reservation(show, places)
  user        = User.first
  reservation = Reservation.new(user: user, show: show)

  places.each do |place|
    reservation.seats.build(code: place, status: Seat::STATUS_RESERVED, taken_by: user, show: show)
  end
  reservation.save(validate: false)
end

Show.all.each do |show|
  total = show.room.total_seats
  available_ratio = show.available_seats_count / show.room.total_seats.to_f
  next if available_ratio < 0.2


  purchase_places = []
  reservation_places = []

  show.available_places.each do |place|
    case rand(10)
    when 0..1
      reservation_places << place
    when 2..7
      purchase_places << place
    else
      # Leave empty
    end
  end

  generate_purchase(show, purchase_places)
  generate_reservation(show, reservation_places)

end

