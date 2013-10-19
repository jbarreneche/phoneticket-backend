class PurchasesController < ApplicationController
  respond_to :html

  def show
    @purchase = Purchase.find(params[:id])
    respond_with @purchase
  end

end
