class CategoriesController < ApplicationController
  def get_data
    @categories = Category.order(:name)
  end

  # GET /categories
  # GET /categories.json
  def index
    get_data

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
      format.js
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.create(params[:category])
    get_data
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
    get_data
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    get_data
  end
end
