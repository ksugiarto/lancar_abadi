class UserGroupsController < ApplicationController
  def get_data_menus_all
    @main_menus = UserMenu.where(:header_id => "A").order(:sub_header_id)
    @setting_menus = UserMenu.where(:header_id => "B").order(:sub_header_id)
  end

  # GET /user_groups
  # GET /user_groups.json
  def index
    @user_groups = UserGroup.order(:name).pagination(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_groups }
      format.js
    end
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
    @user_group = UserGroup.find(params[:id])
    get_data_menus_all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_group }
    end
  end

  # GET /user_groups/new
  # GET /user_groups/new.json
  def new
    @user_group = UserGroup.new
    get_data_menus_all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_group }
    end
  end

  # GET /user_groups/1/edit
  def edit
    @user_group = UserGroup.find(params[:id])
    get_data_menus_all
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    params[:user_group][:user_menu_ids] ||= []
    @user_group = UserGroup.new(params[:user_group])

    respond_to do |format|
      if @user_group.save
        format.html { redirect_to @user_group, notice: 'User group was successfully created.' }
        format.json { render json: @user_group, status: :created, location: @user_group }
      else
        format.html { render action: "new" }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_groups/1
  # PUT /user_groups/1.json
  def update
    params[:user_group][:user_menu_ids] ||= []
    @user_group = UserGroup.find(params[:id])

    respond_to do |format|
      if @user_group.update_attributes(params[:user_group])
        format.html { redirect_to @user_group, notice: 'User group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
  def destroy
    @user_group = UserGroup.find(params[:id])
    @user_group.destroy

    respond_to do |format|
      format.html { redirect_to user_groups_url }
      format.json { head :no_content }
    end
  end
end
