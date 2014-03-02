class PurchaseDetailsController < ApplicationController
  # GET /purchase_details
  # GET /purchase_details.json
  def index
    @purchase_details = PurchaseDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchase_details }
    end
  end

  # GET /purchase_details/1
  # GET /purchase_details/1.json
  def show
    @purchase_detail = PurchaseDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase_detail }
    end
  end

  # GET /purchase_details/new
  # GET /purchase_details/new.json
  def new
    @purchase_detail = PurchaseDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase_detail }
    end
  end

  # GET /purchase_details/1/edit
  def edit
    @purchase_detail = PurchaseDetail.find(params[:id])
  end

  # POST /purchase_details
  # POST /purchase_details.json
  def create
    @purchase_detail = PurchaseDetail.new(params[:purchase_detail])

    respond_to do |format|
      if @purchase_detail.save
        format.html { redirect_to @purchase_detail, notice: 'Purchase detail was successfully created.' }
        format.json { render json: @purchase_detail, status: :created, location: @purchase_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @purchase_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_details/1
  # PUT /purchase_details/1.json
  def update
    @purchase_detail = PurchaseDetail.find(params[:id])

    respond_to do |format|
      if @purchase_detail.update_attributes(params[:purchase_detail])
        format.html { redirect_to @purchase_detail, notice: 'Purchase detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @purchase_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_details/1
  # DELETE /purchase_details/1.json
  def destroy
    @purchase_detail = PurchaseDetail.find(params[:id])
    @purchase_detail.destroy

    respond_to do |format|
      format.html { redirect_to purchase_details_url }
      format.json { head :no_content }
    end
  end
end
