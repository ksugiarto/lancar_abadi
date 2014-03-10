class SaleDetailsController < ApplicationController
  def get_data
    @sale = Sale.find(params[:sale_id])
  end

  # GET /sale_details/new
  # GET /sale_details/new.json
  def new
    get_data
    @sale_detail = @sale.details.new
    @products = Product.order(:name)
  end

  # GET /sale_details/1/edit
  def edit
    get_data
    @sale_detail = @sale.details.find(params[:id])
    @products = Product.order(:name)
  end

  # POST /sale_details
  # POST /sale_details.json
  def create
    get_data
    @sale_detail = @sale.details.create(params[:sale_detail])
    get_data
  end

  # PUT /sale_details/1
  # PUT /sale_details/1.json
  def update
    get_data
    @sale_detail = @sale.details.find(params[:id])
    @sale_detail.update_attributes(params[:sale_detail])
    get_data
  end

  # DELETE /sale_details/1
  # DELETE /sale_details/1.json
  def destroy
    get_data
    @sale_detail = @sale.details.find(params[:id])
    @sale_detail.destroy
    get_data
  end
end
