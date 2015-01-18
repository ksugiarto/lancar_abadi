class UsersController < ApplicationController
  def index
    @users = User.order(:username).pagination(params[:page])

    respond_to do | format |
      format.html
      format.js
    end
  end

  def new
    @user = User.new
    if current_user.user_group.try(:name)!="Developer"
      @user_groups = UserGroup.where("name NOT LIKE ('Developer')")
    else # @user.user_group.try(:name)=="Developer"
      @user_groups = UserGroup.all
    end

    respond_to do | format |
      format.html
    end
  end

  def create
    @user = User.create(params[:user])
    # @user = User.new(params[:user])
    # if @user.save
      # format create_log(subject, object, detail, employee_name)
      # create_log("Create", "User", "Create new user with id:#{@user.id}, username:#{@user.username}, email:#{@user.email}, full name:#{@user.first_name} #{@user.last_name}, user group:#{@user.user_group.try(:name)}.", current_user.full_name)
    # end

    respond_to do |format|
      format.html { redirect_to users_path }
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user.user_group.try(:name)!="Developer"
      @user_groups = UserGroup.where("name NOT LIKE ('Developer')")
    else # @user.user_group.try(:name)=="Developer"
      @user_groups = UserGroup.all
    end

    respond_to do | format |
      format.html
    end
  end

  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(params[:id])
    username=@user.username
    email=@user.email
    user_group=@user.user_group.try(:name)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        # sign_in @user, :bypass => true

        # format create_log(subject, object, detail, employee_name)
        # create_log("Update", "User", "Update user with id:#{@user.id}, username from:#{username} to:#{@user.username}, email from:#{email} to:#{@user.email}, full name from:#{full_name} to:#{@user.first_name} #{@user.last_name}, user group from:#{user_group} to:#{@user.user_group.try(:name)}.", current_user.full_name)

        format.html { redirect_to users_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    # @employee = Employee.where(:user_id => @user.id).last

    # if @employee.blank?
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_path, notice: "#{t 'user.delete_success'}" }
      end
    # else
      # respond_to do |format|
        # format.html { redirect_to users_path, notice: "#{t 'user.delete_failed'}" }
      # end
    # end
  end
end
