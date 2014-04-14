class UserMenusController < ApplicationController
  def get_data_menus_all
    @main_menus = UserMenu.where(:header_id => "A").order(:sub_header_id)
    @setting_menus = UserMenu.where(:header_id => "B").order(:sub_header_id)
  end

  # GET /user_menus
  # GET /user_menus.json
  def index
    get_data_menus_all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_menus }
    end
  end

  # GET /user_menus/new
  # GET /user_menus/new.json
  def new
    @user_menu = UserMenu.new
    @user_menu.header_id = params[:header_id]
    @user_menu.sub_header_id = (UserMenu.where(:header_id => @user_menu.header_id).maximum(:sub_header_id)).to_i+1

    respond_to do |format|
      # format.html # new.html.erb
      format.json { render json: @user_menu }
      format.js
    end
  end

  # GET /user_menus/1/edit
  def edit
    @user_menu = UserMenu.find(params[:id])
  end

  # POST /user_menus
  # POST /user_menus.json
  def create
    @user_menu = UserMenu.new(params[:user_menu])

    respond_to do |format|
      if @user_menu.save
        get_data_menus_all
        # format.html { redirect_to @user_menu, notice: 'User menu was successfully created.' }
        format.json { render json: @user_menu, status: :created, location: @user_menu }
        format.js
      else
        # format.html { render action: "new" }
        format.json { render json: @user_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_menus/1
  # PUT /user_menus/1.json
  def update
    @user_menu = UserMenu.find(params[:id])

    respond_to do |format|
      if @user_menu.update_attributes(params[:user_menu])
        get_data_menus_all
        # format.html { redirect_to @user_menu, notice: 'User menu was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        # format.html { render action: "edit" }
        format.json { render json: @user_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_menus/1
  # DELETE /user_menus/1.json
  def destroy
    @user_menu = UserMenu.find(params[:id])
    @user_menu.destroy

    respond_to do |format|
      format.html { redirect_to user_menus_url }
      format.json { head :no_content }
    end
  end
end
