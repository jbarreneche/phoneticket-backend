json.array! @theatres do |theatre|
  json.(theatre, :id, :name, :latitude, :longitude, :address)
  json.photo_url path_with_host(theatre.photo.url(:android))
  json.resource_url api_theatre_url(theatre)
end
