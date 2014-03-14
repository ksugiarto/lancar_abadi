class ProvincesController < ApplicationController
  def get_data
    @provinces = Province.order(:name).pagination(params[:page])
    @countries = Country.order(:name)
  end

  # GET /provinces
  # GET /provinces.json
  def index
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @provinces }
      format.js
    end
  end

  # GET /provinces/new
  # GET /provinces/new.json
  def new
    @province = Province.new
    get_data
  end

  # GET /provinces/1/edit
  def edit
    @province = Province.find(params[:id])
    get_data
  end

  # POST /provinces
  # POST /provinces.json
  def create
    @province = Province.create(params[:province])
    get_data
  end

  # PUT /provinces/1
  # PUT /provinces/1.json
  def update
    @province = Province.find(params[:id])
    @province.update_attributes(params[:province])
    get_data
  end

  # DELETE /provinces/1
  # DELETE /provinces/1.json
  def destroy
    @province = Province.find(params[:id])
    @province.destroy
    get_data
  end
end
