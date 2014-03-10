class PurchaseDetailsController < ApplicationController
  def get_data
    @purchase = Purchase.find(params[:purchase_id])
  end

  # GET /purchase_details/new
  # GET /purchase_details/new.json
  def new
    get_data
    @purchase_detail = @purchase.details.new
    @products = Product.order(:name)
  end

  # GET /purchase_details/1/edit
  def edit
    get_data
    @purchase_detail = @purchase.details.find(params[:id])
    @products = Product.order(:name)
  end

  # POST /purchase_details
  # POST /purchase_details.json
  def create
    get_data
    @purchase_detail = @purchase.details.create(params[:purchase_detail])
    get_data
  end

  # PUT /purchase_details/1
  # PUT /purchase_details/1.json
  def update
    get_data
    @purchase_detail = @purchase.details.find(params[:id])
    @purchase_detail.update_attributes(params[:purchase_detail])
    get_data
  end

  # DELETE /purchase_details/1
  # DELETE /purchase_details/1.json
  def destroy
    get_data
    @purchase_detail = @purchase.details.find(params[:id])
    @purchase_detail.destroy
    get_data
  end
end
