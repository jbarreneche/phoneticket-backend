class Api::ShowsController < Api::BaseController
  respond_to :json

  def show
    @show = Show.find(params[:id])

    respond_with @show
  end

end
