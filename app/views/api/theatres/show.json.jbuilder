json.(@theatre, :id, :name, :latitude, :longitude, :address)
json.photo_url path_with_host(@theatre.photo.url(:android))

shows_by_movies = @theatre.active_shows.group_by do |show|
  show.movie
end

json.movies shows_by_movies.keys do |movie|
  json.partial! movie

  json.shows shows_by_movies[movie], partial: "api/shows/show", as: :show
end
