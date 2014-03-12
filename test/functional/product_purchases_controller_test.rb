require 'test_helper'

class ProductPurchasesControllerTest < ActionController::TestCase
  setup do
    @product_purchase = product_purchases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_purchases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_purchase" do
    assert_difference('ProductPurchase.count') do
      post :create, product_purchase: { purchase_date: @product_purchase.purchase_date, purchase_price: @product_purchase.purchase_price }
    end

    assert_redirected_to product_purchase_path(assigns(:product_purchase))
  end

  test "should show product_purchase" do
    get :show, id: @product_purchase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_purchase
    assert_response :success
  end

  test "should update product_purchase" do
    put :update, id: @product_purchase, product_purchase: { purchase_date: @product_purchase.purchase_date, purchase_price: @product_purchase.purchase_price }
    assert_redirected_to product_purchase_path(assigns(:product_purchase))
  end

  test "should destroy product_purchase" do
    assert_difference('ProductPurchase.count', -1) do
      delete :destroy, id: @product_purchase
    end

    assert_redirected_to product_purchases_path
  end
end
