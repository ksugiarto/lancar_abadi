class SpecialPricesController < ApplicationController
  def get_data
    @special_prices = SpecialPrice.order(:description).pagination(params[:page])
  end

  # GET /special_prices
  # GET /special_prices.json
  def index
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @special_prices }
      format.js
    end
  end

  # GET /special_prices/new
  # GET /special_prices/new.json
  def new
    @special_price = SpecialPrice.new
  end

  # GET /special_prices/1/edit
  def edit
    @special_price = SpecialPrice.find(params[:id])
  end

  # POST /special_prices
  # POST /special_prices.json
  def create
    @special_price = SpecialPrice.create(params[:special_price])
    get_data
  end

  # PUT /special_prices/1
  # PUT /special_prices/1.json
  def update
    @special_price = SpecialPrice.find(params[:id])
    @special_price.update_attributes(params[:special_price])

    # UPDATE ALL PRODUCTS WITH THIS PRICE
    products = @special_price.products.all
    products.each do |product|
      product.update_attributes(:sales_price => @special_price.try(:price_each_size).to_f * product.size.to_f)
    end
    # END UPDATE ALL PRODUCTS WITH THIS PRICE

    get_data
  end

  # DELETE /special_prices/1
  # DELETE /special_prices/1.json
  def destroy
    @special_price = SpecialPrice.find(params[:id])
    @special_price.destroy
    get_data
  end
end
