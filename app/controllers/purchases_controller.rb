class PurchasesController < ApplicationController
  def get_supplier
    @suppliers = Supplier.search_supplier(params[:keyword])
    .order(:name)
    .paginate(:page => params[:page], :per_page => 5)

    @keyword = params[:keyword] if params[:keyword].present?
  end

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase
    .where("EXTRACT(MONTH FROM transaction_date)=EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM transaction_date)=EXTRACT(YEAR FROM CURRENT_DATE)")
    .order(:created_at).reverse_order
    .pagination(params[:page])

    @suppliers = Supplier.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchases }
    end
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase }
    end
  end

  def show_supplier
    get_supplier
  end

  def search_supplier
    get_supplier
  end

  def pick_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  # GET /purchases/new
  # GET /purchases/new.json
  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /purchases/1/edit
  def edit
    @purchase = Purchase.find(params[:id])

    if @purchase.status.to_i!=0
      redirect_to @purchase
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def edit_footer
    @purchase = Purchase.find(params[:id])
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(params[:purchase])

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.json { render json: @purchase, status: :created, location: @purchase }
      else
        format.html { render action: "new" }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /purchases/1
  # PUT /purchases/1.json
  def update
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :no_content }
    end
  end

  def print_barcode
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.pdf do
        pdf = ProductBarcodePdf.new(@purchase)
        send_data pdf.render, filename: "#{I18n.t 'print'} #{I18n.t 'product.barcode_id'} #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}.pdf",
        type: "application/pdf", :disposition => "inline"
      end 
    end
  end
end
