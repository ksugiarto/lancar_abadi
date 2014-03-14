class CustomersController < ApplicationController
  def get_data
    @countries = Country.order(:name)
    @provinces = Province.order(:name)
    @cities = City.order(:name)
  end

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.order(:name).pagination(params[:page])
    @cities = City.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
      format.js
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new
    get_data
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
    get_data
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    @customers = Customer.order(:name)
  end

  def import
  end

  def import_submit
    Customer.import(params[:file])
    redirect_to customers_path
  end

  def import_phone
  end

  def import_phone_submit
    Customer.import_phone(params[:file])
    redirect_to customers_path
  end
end
