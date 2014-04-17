class EmployeesController < ApplicationController
  def get_data
    @employees = Employee
    .order(:grade, :name)
    # .pagination(params[:page])
  end

  # GET /employees
  # GET /employees.json
  def index
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
      format.js
    end
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.create(params[:employee])
    get_data
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])
    @employee.update_attributes(params[:employee])
    get_data
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    get_data
  end
end
