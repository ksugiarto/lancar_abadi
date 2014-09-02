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
    @special_prices = SpecialPrice.order(:description)
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

    pcs = UnitOfMeasure.where("name ~* 'pcs'").last
    if pcs.blank?
      pcs = UnitOfMeasure.create(:name => "PCS")
    end
    @product.unit_of_measure_id = pcs.id

    get_data_form
  end

  def instant_new
    @product = Product.new
    category = Category.find_by_name("SPAREPART")
    if category.present?
      @product.category_id = category.id      
    end
    
    pcs = UnitOfMeasure.where("name ~* 'pcs'").last
    if pcs.blank?
      pcs = UnitOfMeasure.create(:name => "PCS")
    end
    @product.unit_of_measure_id = pcs.id

    get_data_form

    # if params[:sale_id].to_i==0
      # @purchase = Purchase.find(params[:purchase_id])
    # elsif params[:purchase_id].to_i==0
      @sale = Sale.find(params[:sale_id])
    # else
    # end
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
    if @product.special_price_id.to_i!=0
      @product.sales_price = @product.special_price.try(:price_each_size).to_f * @product.size.to_f
    end

    if @product.try(:category).try(:name)=="SPAREPART"
      get_sparepart
    else
      get_unit
    end

    @product.save

    respond_to do |format|
      format.js
      # if @product.save && @product.try(:category).try(:name)=="SPAREPART"
      #   format.html { redirect_to @product, notice: 'Product was successfully created.' }
      #   format.json { render json: @product, status: :created, location: @product }
      # elsif @product.save && @product.try(:category).try(:name)=="UNIT"
      #   format.html { redirect_to unit_show_product_path(@product), notice: 'Product was successfully created.' }
      #   format.json { render json: @product, status: :created, location: @product }
      # else
      #   format.html { redirect_to @product, notice: 'Product was successfully created.' }
      #   format.json { render json: @product.errors, status: :unprocessable_entity }
      # end
    end
  end

  def instant_create
    @product = Product.new(params[:product])

    if @product.special_price_id.to_i!=0
      @product.sales_price = @product.special_price.try(:price_each_size).to_f * @product.size.to_f
    end

    @product.save

    @products = Product.search_product(params[:keyword], params[:product_type], params[:merk], params[:size])
    .sort_product(params[:column], params[:direction])
    .paginate(:page => params[:page], :per_page => 500)
    # .order(:name, :product_type, :merk, :size)

    @keyword = params[:keyword] if params[:keyword].present?
    @product_type = params[:product_type] if params[:product_type].present?
    @merk = params[:merk] if params[:merk].present?
    @size = params[:size] if params[:size].present?
    @column = params[:column] if params[:column].present?

    @sale = Sale.find(params[:sale_id])

    respond_to do |format|
      format.js
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])

    if @product.special_price_id.to_i!=0
      @product.sales_price = @product.special_price.try(:price_each_size).to_f * @product.size.to_f
    end
    @product.save

    if @product.try(:category).try(:name)=="SPAREPART"
      get_sparepart
    else
      get_unit
    end

    respond_to do |format|
      format.js
      # if @product.try(:category).try(:name)=="SPAREPART"
      #   format.html { redirect_to @product, notice: 'Product was successfully updated.' }
      #   format.json { head :no_content }
      # elsif @product.try(:category).try(:name)=="UNIT"
      #   format.html { redirect_to unit_show_product_path(@product), notice: 'Product was successfully updated.' }
      #   format.json { head :no_content }
      # else
      #   format.html { redirect_to @product }
      #   format.json { render json: @product.errors, status: :unprocessable_entity }
      # end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    if @product.try(:category).try(:name)=="UNIT"
      get_unit
    else
      get_sparepart
    end
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
