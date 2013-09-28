class Api::MoviesController < Api::BaseController

  def index
    @movies = Movie.with_active_shows
    respond_with @movies
  end

  def show
    @movie = Movie.find(params[:id])
    respond_with @movie
  end

end
