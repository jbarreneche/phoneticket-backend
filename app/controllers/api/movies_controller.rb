class Api::MoviesController < Api::BaseController

  def index
    @movies = Movie.with_active_shows
    respond_with @movies
  end

  def show
    @movie = Movie.find(params[:id])
    @shows = @movie.active_shows
    @shows = @shows.joins(:room).where(rooms: {theatre_id: params[:theatre_id]}) if params[:theatre_id]

    respond_with @movie
  end

end
