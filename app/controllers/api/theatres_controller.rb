class Api::TheatresController < Api::BaseController

  def index
    @theatres = Theatre.all
    respond_with @theatres
  end

  def show
    @theatre = Theatre.find(params[:id])
    respond_with @theatre
  end

end
