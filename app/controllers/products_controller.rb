class ProductsController < ApplicationController
  def get_sparepart
    @products = Product.sparepart.pagination(params[:page])
  end

  def get_unit
    @products = Product.unit.pagination(params[:page])
  end

  def get_data
    @suppliers = Supplier.order(:name)

    @store_cust_group = CustomerGroup.find_by_name("Bakul/Toko")
    @workshop_cust_group = CustomerGroup.find_by_name("Bengkel/Montir")
  end

  def get_data_form
    @categories = Category.order(:name)
    @suppliers = Supplier.order(:name)
    @unit_of_measures = UnitOfMeasure.order(:name)
  end

  # GET /products
  # GET /products.json
  def index
    get_sparepart
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
      format.js
    end
  end

  def unit_index
    get_unit
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
      format.js
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    @store_cust_group = CustomerGroup.find_by_name("Bakul/Toko")
    @workshop_cust_group = CustomerGroup.find_by_name("Bengkel/Montir")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def unit_show
    @product = Product.find(params[:id])

    @store_cust_group = CustomerGroup.find_by_name("Bakul/Toko")
    @workshop_cust_group = CustomerGroup.find_by_name("Bengkel/Montir")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    category = Category.find_by_name(params[:category])
    if category.present?
      @product.category_id = category.id      
    end
    get_data_form
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    get_data_form
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save && @product.try(:category).try(:name)=="SPAREPART"
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      elsif @product.save && @product.try(:category).try(:name)=="UNIT"
        format.html { redirect_to unit_show_product_path(@product), notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product]) && @product.try(:category).try(:name)=="SPAREPART"
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      elsif @product.update_attributes(params[:product]) && @product.try(:category).try(:name)=="UNIT"
        format.html { redirect_to unit_show_product_path(@product), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @product }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    get_data
  end

  def import
  end

  def import_submit
    Product.import(params[:file])
    redirect_to products_path
  end

  def generate_barcode
  end

  def generate_barcode_submit
    if params[:start_barcode].to_i==0 && params[:end_barcode].to_i==0
      @products = Product.order(:barcode_id)
    elsif params[:start_barcode].to_i!=0 && params[:end_barcode].to_i==0
      @products = Product.order(:barcode_id).where("barcode_id > '#{params[:start_barcode]}'")
    elsif params[:start_barcode].to_i==0 && params[:end_barcode].to_i!=0
      @products = Product.order(:barcode_id).where("barcode_id < '#{params[:end_barcode]}'")
    else
      @products = Product.order(:barcode_id).where("barcode_id > '#{params[:start_barcode]}' AND barcode_id < '#{params[:end_barcode]}'")
    end

    respond_to do |format|
      format.pdf do
        pdf = ProductBarcodePdf.new(@products)
        send_data pdf.render, filename: "#{I18n.t 'product.barcode_id'} #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}.pdf",
        type: "application/pdf", :disposition => "inline"
      end 
    end
  end
end
