theatre_1, theatre_2, theatre_3 = ["Cine 1", "Cine 2", "Cine 3"].map do |name|
  theatre = Theatre.where(name: name).first_or_initialize
  theatre.update_attributes({})
  theatre
end

rooms = [theatre_1, theatre_2, theatre_3].flat_map do |theatre|
  room_1 = theatre.rooms.where(name: "Sala 1").first_or_initialize
  room_1.update_attributes(
    shape: "standard"
  )
  room_2 = theatre.rooms.where(name: "Sala 2").first_or_initialize
  room_2.update_attributes(
    shape: "standard"
  )
  [room_1, room_2]
end

matrix = Movie.where(title: "Matrix").first_or_initialize
matrix.update_attributes(
  youtube_trailer: "http://www.youtube.com/watch?v=m8e-FF8MsqU",
  synopsis: <<-SYN.strip_heredoc
  A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.
  SYN
)

planes = Movie.where(title: "Aviones").first_or_initialize
planes.update_attributes(
  youtube_trailer: "http://www.youtube.com/watch?v=YRjztG65XgI",
  synopsis: <<-SYN.strip_heredoc
  A cropdusting plane with a fear of heights lives his dream of competing in a famous around-the-world aerial race.
  SYN
)

matrix_rooms = rooms[0...3]
planes_rooms = rooms[3...6]

thursday = Date.today.next_week(:thursday)

(matrix_rooms * 2).zip %w[19:00 20:30 21:00 21:30].cycle do |room, time|
  room.shows.where(starts_at: Time.zone.parse("#{thursday} #{time}"), movie: matrix).first_or_create!
end

(planes_rooms * 2).zip %w[16:30 19:00 22:30 23:15].cycle do |room, time|
  room.shows.where(starts_at: Time.zone.parse("#{thursday} #{time}"), movie: planes).first_or_create!
end
