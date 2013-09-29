module MovieHelper
  def audience_ratings_collection
    Movie::AUDIENCE_RATINGS
  end

  def genres_collection
    Hash[Movie::GENRES.map do |genre|
      [human_genre(genre), genre]
    end]
  end

  def human_genre(genre)
    I18n.t("movie.genres.#{genre}", default: genre.titleize) if genre
  end
end
