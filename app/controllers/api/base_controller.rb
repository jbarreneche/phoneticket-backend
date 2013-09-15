class Api::BaseController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :english_locale

  respond_to :json, :xml

  private

  def english_locale
    I18n.locale = :en
  end

end
