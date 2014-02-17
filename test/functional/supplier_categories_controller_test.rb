require 'test_helper'

class SupplierCategoriesControllerTest < ActionController::TestCase
  setup do
    @supplier_category = supplier_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplier_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier_category" do
    assert_difference('SupplierCategory.count') do
      post :create, supplier_category: { notes: @supplier_category.notes }
    end

    assert_redirected_to supplier_category_path(assigns(:supplier_category))
  end

  test "should show supplier_category" do
    get :show, id: @supplier_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @supplier_category
    assert_response :success
  end

  test "should update supplier_category" do
    put :update, id: @supplier_category, supplier_category: { notes: @supplier_category.notes }
    assert_redirected_to supplier_category_path(assigns(:supplier_category))
  end

  test "should destroy supplier_category" do
    assert_difference('SupplierCategory.count', -1) do
      delete :destroy, id: @supplier_category
    end

    assert_redirected_to supplier_categories_path
  end
end
