class UnitOfMeasuresController < ApplicationController
  def get_data
    @unit_of_measures = UnitOfMeasure.order(:name).pagination(params[:page])
  end

  # GET /unit_of_measures
  # GET /unit_of_measures.json
  def index
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @unit_of_measures }
      format.js
    end
  end

  # GET /unit_of_measures/new
  # GET /unit_of_measures/new.json
  def new
    @unit_of_measure = UnitOfMeasure.new
  end

  # GET /unit_of_measures/1/edit
  def edit
    @unit_of_measure = UnitOfMeasure.find(params[:id])
  end

  # POST /unit_of_measures
  # POST /unit_of_measures.json
  def create
    @unit_of_measure = UnitOfMeasure.create(params[:unit_of_measure])
    get_data
  end

  # PUT /unit_of_measures/1
  # PUT /unit_of_measures/1.json
  def update
    @unit_of_measure = UnitOfMeasure.find(params[:id])
    @unit_of_measure.update_attributes(params[:unit_of_measure])
    get_data
  end

  # DELETE /unit_of_measures/1
  # DELETE /unit_of_measures/1.json
  def destroy
    @unit_of_measure = UnitOfMeasure.find(params[:id])
    @unit_of_measure.destroy
    get_data
  end
end
