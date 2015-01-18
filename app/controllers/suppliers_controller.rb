class SuppliersController < ApplicationController
  def get_data
    @countries = Country.order(:name)
    @provinces = Province.order(:name)
    @cities = City.order(:name)
  end

  # GET /suppliers
  # GET /suppliers.json
  def index
    @suppliers = Supplier.order(:name).pagination(params[:page])
    @cities = City.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suppliers }
      format.js
    end
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
    @supplier = Supplier.find(params[:id])

    @products = @supplier.products.order(:name).paginate(:per_page => 10, :page => params[:page])

    @store_cust_group = CustomerGroup.find_by_name("Bakul/Toko")
    @workshop_cust_group = CustomerGroup.find_by_name("Bengkel/Montir")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supplier }
      format.js
    end
  end

  # GET /suppliers/new
  # GET /suppliers/new.json
  def new
    @supplier = Supplier.new
    get_data
  end

  # GET /suppliers/1/edit
  def edit
    @supplier = Supplier.find(params[:id])
    get_data
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(params[:supplier])

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'Supplier was successfully created.' }
        format.json { render json: @supplier, status: :created, location: @supplier }
      else
        format.html { render action: "new" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /suppliers/1
  # PUT /suppliers/1.json
  def update
    @supplier = Supplier.find(params[:id])

    respond_to do |format|
      if @supplier.update_attributes(params[:supplier])
        format.html { redirect_to @supplier, notice: 'Supplier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    @suppliers = Supplier.order(:name).pagination(params[:page])

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def import
  end

  def import_submit
    Supplier.import(params[:file])
    redirect_to suppliers_path
  end

  def import_phone
  end

  def import_phone_submit
    Supplier.import_phone(params[:file])
    redirect_to suppliers_path
  end
end
