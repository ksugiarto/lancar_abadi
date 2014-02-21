class CustomerPhonesController < ApplicationController
  def get_customer
    @customer = Customer.find(params[:customer_id])
  end

  # GET /customer_phones/new
  # GET /customer_phones/new.json
  def new
    get_customer
    @customer_phone = @customer.phones.new
  end

  # GET /customer_phones/1/edit
  def edit
    get_customer
    @customer_phone = @customer.phones.find(params[:id])
  end

  # POST /customer_phones
  # POST /customer_phones.json
  def create
    get_customer
    @customer_phone = @customer.phones.create(params[:customer_phone])
  end

  # PUT /customer_phones/1
  # PUT /customer_phones/1.json
  def update
    get_customer
    @customer_phone = @customer.phones.find(params[:id])
    @customer_phone.update_attributes(params[:customer_phone])
  end

  # DELETE /customer_phones/1
  # DELETE /customer_phones/1.json
  def destroy
    get_customer
    @customer_phone = @customer.phones.find(params[:id])
    @customer_phone.destroy
  end
end
