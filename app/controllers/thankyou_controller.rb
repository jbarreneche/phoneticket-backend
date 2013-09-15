class ThankyouController < ApplicationController

  def page
    render params[:page]
  end

end
