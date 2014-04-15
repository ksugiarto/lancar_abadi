require 'test_helper'

class CompanyProfilesControllerTest < ActionController::TestCase
  setup do
    @company_profile = company_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_profile" do
    assert_difference('CompanyProfile.count') do
      post :create, company_profile: { address: @company_profile.address, fax: @company_profile.fax, is_pkp: @company_profile.is_pkp, name: @company_profile.name, npwp: @company_profile.npwp, primary_bank_account: @company_profile.primary_bank_account, primary_bank_account_name: @company_profile.primary_bank_account_name, primary_bank_name: @company_profile.primary_bank_name, secondary_bank_account: @company_profile.secondary_bank_account, secondary_bank_account_name: @company_profile.secondary_bank_account_name, secondary_bank_name: @company_profile.secondary_bank_name, telephone: @company_profile.telephone }
    end

    assert_redirected_to company_profile_path(assigns(:company_profile))
  end

  test "should show company_profile" do
    get :show, id: @company_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company_profile
    assert_response :success
  end

  test "should update company_profile" do
    put :update, id: @company_profile, company_profile: { address: @company_profile.address, fax: @company_profile.fax, is_pkp: @company_profile.is_pkp, name: @company_profile.name, npwp: @company_profile.npwp, primary_bank_account: @company_profile.primary_bank_account, primary_bank_account_name: @company_profile.primary_bank_account_name, primary_bank_name: @company_profile.primary_bank_name, secondary_bank_account: @company_profile.secondary_bank_account, secondary_bank_account_name: @company_profile.secondary_bank_account_name, secondary_bank_name: @company_profile.secondary_bank_name, telephone: @company_profile.telephone }
    assert_redirected_to company_profile_path(assigns(:company_profile))
  end

  test "should destroy company_profile" do
    assert_difference('CompanyProfile.count', -1) do
      delete :destroy, id: @company_profile
    end

    assert_redirected_to company_profiles_path
  end
end
