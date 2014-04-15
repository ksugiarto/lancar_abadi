class CompanyProfilesController < ApplicationController
  def get_geographic_data
    @countries = Country.order(:name)
    @provinces = Province.order(:name)
    @cities = City.order(:name)
  end

  # GET /company_profiles
  # GET /company_profiles.json
  def index
    @company_profiles = CompanyProfile.all

    if @company_profiles.blank?
      redirect_to new_company_profile_path
    else
      @company_profile = CompanyProfile.last
      redirect_to @company_profile
    end
  end

  # GET /company_profiles/1
  # GET /company_profiles/1.json
  def show
    @company_profile = CompanyProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company_profile }
    end
  end

  # GET /company_profiles/new
  # GET /company_profiles/new.json
  def new
    @company_profile = CompanyProfile.new
    get_geographic_data

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company_profile }
    end
  end

  # GET /company_profiles/1/edit
  def edit
    @company_profile = CompanyProfile.find(params[:id])
    get_geographic_data
  end

  # POST /company_profiles
  # POST /company_profiles.json
  def create
    @company_profile = CompanyProfile.new(params[:company_profile])
    get_geographic_data

    respond_to do |format|
      if @company_profile.save
        format.html { redirect_to @company_profile, notice: 'Company profile was successfully created.' }
        format.json { render json: @company_profile, status: :created, location: @company_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @company_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /company_profiles/1
  # PUT /company_profiles/1.json
  def update
    @company_profile = CompanyProfile.find(params[:id])
    get_geographic_data

    respond_to do |format|
      if @company_profile.update_attributes(params[:company_profile])
        format.html { redirect_to @company_profile, notice: 'Company profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company_profile.errors, status: :unprocessable_entity }
      end
    end
  end
end
