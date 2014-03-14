class CitiesController < ApplicationController
  def get_data
    @countries = Country.order(:name)
    @provinces = Province.order(:name)
    @cities = City.order(:name).pagination(params[:page])
  end

  # GET /cities
  # GET /cities.json
  def index
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities }
      format.js
    end
  end

  # GET /cities/new
  # GET /cities/new.json
  def new
    @city = City.new
    get_data
  end

  # GET /cities/1/edit
  def edit
    @city = City.find(params[:id])
    get_data
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.create(params[:city])
    get_data
  end

  # PUT /cities/1
  # PUT /cities/1.json
  def update
    @city = City.find(params[:id])
    @city.update_attributes(params[:city])
    get_data
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city = City.find(params[:id])
    @city.destroy
    get_data
  end
end
