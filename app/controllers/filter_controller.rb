class FilterController < ApplicationController
	# THIS IS PLACE FOR ALL FILTER
  # JUST FOR SAKE THE MODEL VIEWS FOLDER NOT MORE CROWDED

  # MASTER======
  def country
    @countries = Country
    .filter_name(params[:name])
    .order(:name)
    .pagination(params[:page])
  end

  def province
    @provinces = Province
    .filter_country(params[:country_id])
    .filter_name(params[:name])
    .order(:name)
    .pagination(params[:page])
  end

  def city
    @cities = City
    .filter_country(params[:country_id])
    .filter_province(params[:province_id])
    .filter_name(params[:name])
    .order(:name)
    .pagination(params[:page])
  end

  def unit_of_measure
  	@unit_of_measures = UnitOfMeasure
    .filter_name(params[:name])
  	.order(:name)
    .pagination(params[:page])
  end

  def category
  	@categories = Category
  	.filter_name(params[:name])
  	.order(:name)
    .pagination(params[:page])
  end

  def customer_group
  	@customer_groups = CustomerGrup
  	.filter_name(params[:name])
  	.order(:name)
    .pagination(params[:page])
  end

  def supplier
  	@suppliers = Supplier
  	.filter_name(params[:name])
    .filter_city(params[:city_id])
  	.order(:name)
    .pagination(params[:page])
  end

  def customer
  	@customers = Customer
  	.filter_name(params[:name])
    .filter_city(params[:city_id])
  	.order(:name)
    .pagination(params[:page])
  end

  def product
  	@products = Product
  	.filter_name(params[:name])
    .filter_supplier(params[:supplier_id])
  	.order(:name)
    .pagination(params[:page])

    @store_cust_group = CustomerGroup.find_by_name("Bakul/Toko")
    @workshop_cust_group = CustomerGroup.find_by_name("Bengkel/Montir")
  end

  def product_home
    @products = Product
    .filter_name(params[:name])
    .filter_supplier(params[:supplier_id])
    .order(:name)
    .pagination(params[:page])

    @store_cust_group = CustomerGroup.find_by_name("Bakul/Toko")
    @workshop_cust_group = CustomerGroup.find_by_name("Bengkel/Montir")
  end

  def purchase
  	@purchases = Purchase
  	.filter_month(params[:month])
    .filter_year(params[:year])
    .filter_supplier(params[:supplier_id].to_i)
    .filter_status(params[:status])
    .order(:created_at).reverse_order
    .pagination(params[:page])
  end

  def sale
  	@sales = Sale
  	.filter_month(params[:month])
    .filter_year(params[:year])
    .filter_customer(params[:customer_id].to_i)
    .filter_status(params[:status])
    .order(:created_at).reverse_order
    .pagination(params[:page])
  end
end