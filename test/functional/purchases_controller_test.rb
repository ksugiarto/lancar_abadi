require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  setup do
    @purchase = purchases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post :create, purchase: { added_discount: @purchase.added_discount, amount_after_discount: @purchase.amount_after_discount, discount: @purchase.discount, discount_amount: @purchase.discount_amount, notes: @purchase.notes, pi_id: @purchase.pi_id, sub_amount: @purchase.sub_amount, tax: @purchase.tax, tax_amount: @purchase.tax_amount, total_amount: @purchase.total_amount, transaction_date: @purchase.transaction_date }
    end

    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should show purchase" do
    get :show, id: @purchase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase
    assert_response :success
  end

  test "should update purchase" do
    put :update, id: @purchase, purchase: { added_discount: @purchase.added_discount, amount_after_discount: @purchase.amount_after_discount, discount: @purchase.discount, discount_amount: @purchase.discount_amount, notes: @purchase.notes, pi_id: @purchase.pi_id, sub_amount: @purchase.sub_amount, tax: @purchase.tax, tax_amount: @purchase.tax_amount, total_amount: @purchase.total_amount, transaction_date: @purchase.transaction_date }
    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete :destroy, id: @purchase
    end

    assert_redirected_to purchases_path
  end
end
