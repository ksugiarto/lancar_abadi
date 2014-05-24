class ProductDetailsController < ApplicationController
  def get_product
    @product = Product.find(params[:product_id])
    @unit_of_measures = UnitOfMeasure.order(:name)
  end

  # GET /product_details/new
  # GET /product_details/new.json
  def new
    get_product
    @product_detail = @product.details.new
  end

  # GET /product_details/1/edit
  def edit
    get_product
    @product_detail = @product.details.find(params[:id])
  end

  # POST /product_details
  # POST /product_details.json
  def create
    get_product
    @product_detail = @product.details.create(params[:product_detail])
  end

  # PUT /product_details/1
  # PUT /product_details/1.json
  def update
    get_product
    @product_detail = @product.details.find(params[:id])
    @product_detail.update_attributes(params[:product_detail])
  end

  # DELETE /product_details/1
  # DELETE /product_details/1.json
  def destroy
    get_product
    @product_detail = @product.details.find(params[:id])
    @product_detail.destroy
  end
end
