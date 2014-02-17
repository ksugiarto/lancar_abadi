require 'test_helper'

class SupplierPhonesControllerTest < ActionController::TestCase
  setup do
    @supplier_phone = supplier_phones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplier_phones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier_phone" do
    assert_difference('SupplierPhone.count') do
      post :create, supplier_phone: { country_ext: @supplier_phone.country_ext, description: @supplier_phone.description, phone_number: @supplier_phone.phone_number }
    end

    assert_redirected_to supplier_phone_path(assigns(:supplier_phone))
  end

  test "should show supplier_phone" do
    get :show, id: @supplier_phone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @supplier_phone
    assert_response :success
  end

  test "should update supplier_phone" do
    put :update, id: @supplier_phone, supplier_phone: { country_ext: @supplier_phone.country_ext, description: @supplier_phone.description, phone_number: @supplier_phone.phone_number }
    assert_redirected_to supplier_phone_path(assigns(:supplier_phone))
  end

  test "should destroy supplier_phone" do
    assert_difference('SupplierPhone.count', -1) do
      delete :destroy, id: @supplier_phone
    end

    assert_redirected_to supplier_phones_path
  end
end
