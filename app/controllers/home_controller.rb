class HomeController < ApplicationController
  def index
    @products = Product.where(:id => 0).order(:name).pagination(params[:page])
    @suppliers = Supplier.order(:name)

    @store_cust_group = CustomerGroup.find_by_name("Bakul/Toko")
    @workshop_cust_group = CustomerGroup.find_by_name("Bengkel/Montir")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
      format.js
    end
  end

  def provinces_by_country
  	if params[:id].present?
  		country = Country.find(params[:id])
  		@provinces = country.provinces.order(:name)
    else
      @provinces = Province.order(:name)
    end
    @cities = [] #probably need to be updated further

  	respond_to do |format|
  		format.js
  	end
  end

  def cities_by_province
  	if params[:id].present?
  		province = Province.find(params[:id])
  		@cities = province.cities.order(:name)
  	else
  		@cities = City.order(:name)
  	end

  	respond_to do |format|
  		format.js
  	end
  end
end
