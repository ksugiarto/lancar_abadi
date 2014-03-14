class CustomerGroupsController < ApplicationController
  def get_data
    @customer_groups = CustomerGroup.order(:name).pagination(params[:page])
  end

  # GET /customer_groups
  # GET /customer_groups.json
  def index
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer_groups }
      format.js
    end
  end

  # GET /customer_groups/new
  # GET /customer_groups/new.json
  def new
    @customer_group = CustomerGroup.new
  end

  # GET /customer_groups/1/edit
  def edit
    @customer_group = CustomerGroup.find(params[:id])
  end

  # POST /customer_groups
  # POST /customer_groups.json
  def create
    @customer_group = CustomerGroup.create(params[:customer_group])
    get_data
  end

  # PUT /customer_groups/1
  # PUT /customer_groups/1.json
  def update
    @customer_group = CustomerGroup.find(params[:id])
    @customer_group.update_attributes(params[:customer_group])
    get_data
  end

  # DELETE /customer_groups/1
  # DELETE /customer_groups/1.json
  def destroy
    @customer_group = CustomerGroup.find(params[:id])
    @customer_group.destroy
    get_data
  end
end
