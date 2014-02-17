class SupplierPhonesController < ApplicationController
  def get_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  # GET /supplier_phones/new
  # GET /supplier_phones/new.json
  def new
    get_supplier
    @supplier_phone = @supplier.phones.new
  end

  # GET /supplier_phones/1/edit
  def edit
    get_supplier
    @supplier_phone = @supplier.phones.find(params[:id])
  end

  # POST /supplier_phones
  # POST /supplier_phones.json
  def create
    get_supplier
    @supplier_phone = @supplier.phones.create(params[:supplier_phone])
  end

  # PUT /supplier_phones/1
  # PUT /supplier_phones/1.json
  def update
    get_supplier
    @supplier_phone = @supplier.phones.find(params[:id])
    @supplier_phone.update_attributes(params[:supplier_phone])
  end

  # DELETE /supplier_phones/1
  # DELETE /supplier_phones/1.json
  def destroy
    get_supplier
    @supplier_phone = @supplier.phones.find(params[:id])
    @supplier_phone.destroy
  end
end
