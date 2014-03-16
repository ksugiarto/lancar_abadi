class SalesController < ApplicationController
  def get_customer
    @customers = Customer.search_customer(params[:keyword])
    .order(:name)
    .paginate(:page => params[:page], :per_page => 5)

    @keyword = params[:keyword] if params[:keyword].present?
  end

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale
    .where("EXTRACT(MONTH FROM transaction_date)=EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM transaction_date)=EXTRACT(YEAR FROM CURRENT_DATE)")
    .order(:created_at).reverse_order
    .pagination(params[:page])

    @customers = Customer.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sales }
    end
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
    @sale = Sale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale }
      format.pdf do
        pdf = SaleIndividualPdf.new(@sale.id)
        send_data pdf.render, filename: "#{I18n.t 'sale.sales_invoice'} #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}.pdf",
        type: "application/pdf", :disposition => "inline"
      end
    end
  end

  def show_customer
    get_customer
  end

  def search_customer
    get_customer
  end

  def pick_customer
    @customer = Customer.find(params[:customer_id])
  end

  # GET /sales/new
  # GET /sales/new.json
  def new
    @sale = Sale.new
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
    
    if @sale.status.to_i!=0
      redirect_to @sale
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def edit_footer
    @sale = Sale.find(params[:id])
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render json: @sale, status: :created, location: @sale }
      else
        format.html { render action: "new" }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sales/1
  # PUT /sales/1.json
  def update
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to sales_url }
      format.json { head :no_content }
    end
  end
end
