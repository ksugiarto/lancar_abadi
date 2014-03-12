class SaleDetailsController < ApplicationController
  def get_data
    @sale = Sale.find(params[:sale_id])
  end

  def get_product
    @products = Product.search_product(params[:keyword]).order(:name)
    .paginate(:page => params[:page], :per_page => 1)

    @keyword = params[:keyword] if params[:keyword].present?
  end

  def show_product
    get_data
    get_product
  end

  def search_product
    get_data
    get_product
  end

  def pick_product
    @product = Product.find(params[:product_id])
  end

  # GET /sale_details/new
  # GET /sale_details/new.json
  def new
    get_data
    @sale_detail = @sale.details.new
  end

  # GET /sale_details/1/edit
  def edit
    get_data
    @sale_detail = @sale.details.find(params[:id])
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
