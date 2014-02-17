class SupplierCategoriesController < ApplicationController
  def get_categories
    @categories = Category.order(:name)
  end

  def get_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  # GET /supplier_categories/new
  # GET /supplier_categories/new.json
  def new
    get_supplier
    get_categories
    @supplier_category = @supplier.categories.new
  end

  # GET /supplier_categories/1/edit
  def edit
    get_supplier
    get_categories
    @supplier_category = @supplier.categories.find(params[:id])
  end

  # POST /supplier_categories
  # POST /supplier_categories.json
  def create
    get_supplier
    @supplier_category = @supplier.categories.create(params[:supplier_category])
  end

  # PUT /supplier_categories/1
  # PUT /supplier_categories/1.json
  def update
    get_supplier
    @supplier_category = @supplier.categories.find(params[:id])
    @supplier_category.update_attributes(params[:supplier_category])
  end

  # DELETE /supplier_categories/1
  # DELETE /supplier_categories/1.json
  def destroy
    get_supplier
    @supplier_category = @supplier.categories.find(params[:id])
    @supplier_category.destroy
  end
end
