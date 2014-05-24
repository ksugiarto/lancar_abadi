require 'test_helper'

class ProductDetailsControllerTest < ActionController::TestCase
  setup do
    @product_detail = product_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_detail" do
    assert_difference('ProductDetail.count') do
      post :create, product_detail: { sales_price: @product_detail.sales_price }
    end

    assert_redirected_to product_detail_path(assigns(:product_detail))
  end

  test "should show product_detail" do
    get :show, id: @product_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_detail
    assert_response :success
  end

  test "should update product_detail" do
    put :update, id: @product_detail, product_detail: { sales_price: @product_detail.sales_price }
    assert_redirected_to product_detail_path(assigns(:product_detail))
  end

  test "should destroy product_detail" do
    assert_difference('ProductDetail.count', -1) do
      delete :destroy, id: @product_detail
    end

    assert_redirected_to product_details_path
  end
end
