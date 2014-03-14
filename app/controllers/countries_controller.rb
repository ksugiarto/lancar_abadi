class CountriesController < ApplicationController
  def get_data
    @countries = Country.order(:name).pagination(params[:page])
  end

  # GET /countries
  # GET /countries.json
  def index
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countries }
      format.js
    end
  end

  # GET /countries/new
  # GET /countries/new.json
  def new
    @country = Country.new
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.create(params[:country])
    get_data
  end

  # PUT /countries/1
  # PUT /countries/1.json
  def update
    @country = Country.find(params[:id])
    @country.update_attributes(params[:country])
    get_data
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country = Country.find(params[:id])
    @country.destroy
    get_data
  end
end
