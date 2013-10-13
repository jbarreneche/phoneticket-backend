class MoviesController < ApplicationController
  respond_to :html

  def show
    @movie = Movie.find(params[:id])
    respond_with @movie
  end

end
