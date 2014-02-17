class CustomerPhonesController < ApplicationController
  # GET /customer_phones
  # GET /customer_phones.json
  def index
    @customer_phones = CustomerPhone.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer_phones }
    end
  end

  # GET /customer_phones/1
  # GET /customer_phones/1.json
  def show
    @customer_phone = CustomerPhone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer_phone }
    end
  end

  # GET /customer_phones/new
  # GET /customer_phones/new.json
  def new
    @customer_phone = CustomerPhone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer_phone }
    end
  end

  # GET /customer_phones/1/edit
  def edit
    @customer_phone = CustomerPhone.find(params[:id])
  end

  # POST /customer_phones
  # POST /customer_phones.json
  def create
    @customer_phone = CustomerPhone.new(params[:customer_phone])

    respond_to do |format|
      if @customer_phone.save
        format.html { redirect_to @customer_phone, notice: 'Customer phone was successfully created.' }
        format.json { render json: @customer_phone, status: :created, location: @customer_phone }
      else
        format.html { render action: "new" }
        format.json { render json: @customer_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customer_phones/1
  # PUT /customer_phones/1.json
  def update
    @customer_phone = CustomerPhone.find(params[:id])

    respond_to do |format|
      if @customer_phone.update_attributes(params[:customer_phone])
        format.html { redirect_to @customer_phone, notice: 'Customer phone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_phones/1
  # DELETE /customer_phones/1.json
  def destroy
    @customer_phone = CustomerPhone.find(params[:id])
    @customer_phone.destroy

    respond_to do |format|
      format.html { redirect_to customer_phones_url }
      format.json { head :no_content }
    end
  end
end
