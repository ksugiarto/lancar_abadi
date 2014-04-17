class EmpDatesController < ApplicationController
  # GET /emp_dates
  # GET /emp_dates.json
  def index
    @emp_dates = EmpDate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emp_dates }
    end
  end

  # GET /emp_dates/1
  # GET /emp_dates/1.json
  def show
    @emp_date = EmpDate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emp_date }
    end
  end

  # GET /emp_dates/new
  # GET /emp_dates/new.json
  def new
    @emp_date = EmpDate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @emp_date }
    end
  end

  # GET /emp_dates/1/edit
  def edit
    @emp_date = EmpDate.find(params[:id])
  end

  # POST /emp_dates
  # POST /emp_dates.json
  def create
    @emp_date = EmpDate.new(params[:emp_date])

    respond_to do |format|
      if @emp_date.save
        format.html { redirect_to @emp_date, notice: 'Emp date was successfully created.' }
        format.json { render json: @emp_date, status: :created, location: @emp_date }
      else
        format.html { render action: "new" }
        format.json { render json: @emp_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emp_dates/1
  # PUT /emp_dates/1.json
  def update
    @emp_date = EmpDate.find(params[:id])

    respond_to do |format|
      if @emp_date.update_attributes(params[:emp_date])
        format.html { redirect_to @emp_date, notice: 'Emp date was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @emp_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emp_dates/1
  # DELETE /emp_dates/1.json
  def destroy
    @emp_date = EmpDate.find(params[:id])
    @emp_date.destroy

    respond_to do |format|
      format.html { redirect_to emp_dates_url }
      format.json { head :no_content }
    end
  end
end
