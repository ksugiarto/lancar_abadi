class EmpDateDetailsController < ApplicationController
  # GET /emp_date_details
  # GET /emp_date_details.json
  def index
    @emp_date_details = EmpDateDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emp_date_details }
    end
  end

  # GET /emp_date_details/1
  # GET /emp_date_details/1.json
  def show
    @emp_date_detail = EmpDateDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emp_date_detail }
    end
  end

  # GET /emp_date_details/new
  # GET /emp_date_details/new.json
  def new
    @emp_date_detail = EmpDateDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @emp_date_detail }
    end
  end

  # GET /emp_date_details/1/edit
  def edit
    @emp_date_detail = EmpDateDetail.find(params[:id])
  end

  # POST /emp_date_details
  # POST /emp_date_details.json
  def create
    @emp_date_detail = EmpDateDetail.new(params[:emp_date_detail])

    respond_to do |format|
      if @emp_date_detail.save
        format.html { redirect_to @emp_date_detail, notice: 'Emp date detail was successfully created.' }
        format.json { render json: @emp_date_detail, status: :created, location: @emp_date_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @emp_date_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emp_date_details/1
  # PUT /emp_date_details/1.json
  def update
    @emp_date_detail = EmpDateDetail.find(params[:id])

    respond_to do |format|
      if @emp_date_detail.update_attributes(params[:emp_date_detail])
        format.html { redirect_to @emp_date_detail, notice: 'Emp date detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @emp_date_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emp_date_details/1
  # DELETE /emp_date_details/1.json
  def destroy
    @emp_date_detail = EmpDateDetail.find(params[:id])
    @emp_date_detail.destroy

    respond_to do |format|
      format.html { redirect_to emp_date_details_url }
      format.json { head :no_content }
    end
  end
end
