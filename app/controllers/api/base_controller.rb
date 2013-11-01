class Api::BaseController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json, :xml

  #
  rescue_from ActiveRecord::RecordNotFound do |exception|
    entity = (exception.message.match(/find (\w+)/).try(:[], 1) || "resource").underscore

    render json: {
      errors: {
        entity => "Inexistente"
      }
    }, status: :not_found
  end

  private

  def ensure_user
    raise ActiveRecord::RecordNotFound, "Couldn't find User" unless current_user
  end

  def current_user
    @current_user ||= User.find_by_email params[:email]
  end

end
