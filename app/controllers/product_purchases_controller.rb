class ProductPurchasesController < ApplicationController
  # GET /product_purchases
  # GET /product_purchases.json
  def index
    @product_purchases = ProductPurchase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_purchases }
    end
  end

  # GET /product_purchases/1
  # GET /product_purchases/1.json
  def show
    @product_purchase = ProductPurchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_purchase }
    end
  end

  # GET /product_purchases/new
  # GET /product_purchases/new.json
  def new
    @product_purchase = ProductPurchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_purchase }
    end
  end

  # GET /product_purchases/1/edit
  def edit
    @product_purchase = ProductPurchase.find(params[:id])
  end

  # POST /product_purchases
  # POST /product_purchases.json
  def create
    @product_purchase = ProductPurchase.new(params[:product_purchase])

    respond_to do |format|
      if @product_purchase.save
        format.html { redirect_to @product_purchase, notice: 'Product purchase was successfully created.' }
        format.json { render json: @product_purchase, status: :created, location: @product_purchase }
      else
        format.html { render action: "new" }
        format.json { render json: @product_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_purchases/1
  # PUT /product_purchases/1.json
  def update
    @product_purchase = ProductPurchase.find(params[:id])

    respond_to do |format|
      if @product_purchase.update_attributes(params[:product_purchase])
        format.html { redirect_to @product_purchase, notice: 'Product purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_purchases/1
  # DELETE /product_purchases/1.json
  def destroy
    @product_purchase = ProductPurchase.find(params[:id])
    @product_purchase.destroy

    respond_to do |format|
      format.html { redirect_to product_purchases_url }
      format.json { head :no_content }
    end
  end
end
