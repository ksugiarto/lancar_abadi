class PurchaseDetailsController < ApplicationController
  def get_data
    @purchase = Purchase.find(params[:purchase_id])
  end

  def get_product
    @products = Product
    .search_product(params[:keyword])
    .where(:supplier_id => @purchase.supplier_id)
    .order(:name)
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
    @last_purchase_price = @product.purchases.last.try(:purchase_price).to_f
  end

  # GET /purchase_details/new
  # GET /purchase_details/new.json
  def new
    get_data
    @purchase_detail = @purchase.details.new
    @purchase_detail.quantity = 1
  end

  # GET /purchase_details/1/edit
  def edit
    get_data
    @purchase_detail = @purchase.details.find(params[:id])
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
