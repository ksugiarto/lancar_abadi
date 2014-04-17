class AdjustmentDetailsController < ApplicationController
  def get_data
    @adjustment = Adjustment.find(params[:adjustment_id])
  end

  def get_product
    @products = Product
    .search_product(params[:keyword])
    .order(:name, :product_type, :merk)
    .paginate(:page => params[:page], :per_page => 500)

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

  # GET /adjustment_details/new
  # GET /adjustment_details/new.json
  def new
    get_data
    @adjustment_detail = @adjustment.details.new
    @adjustment_detail.quantity_print = ""
  end

  # GET /adjustment_details/1/edit
  def edit
    get_data
    @adjustment_detail = @adjustment.details.find(params[:id])
  end

  # POST /adjustment_details
  # POST /adjustment_details.json
  def create
    get_data
    @adjustment_detail = @adjustment.details.create(params[:adjustment_detail])
    get_data
  end

  # PUT /adjustment_details/1
  # PUT /adjustment_details/1.json
  def update
    get_data
    @adjustment_detail = @adjustment.details.find(params[:id])
    @adjustment_detail.update_attributes(params[:adjustment_detail])
    get_data
  end

  # DELETE /adjustment_details/1
  # DELETE /adjustment_details/1.json
  def destroy
    get_data
    @adjustment_detail = @adjustment.details.find(params[:id])
    @adjustment_detail.destroy
    get_data
  end
end
