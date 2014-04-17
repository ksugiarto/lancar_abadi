require 'test_helper'

class AdjustmentDetailsControllerTest < ActionController::TestCase
  setup do
    @adjustment_detail = adjustment_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adjustment_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adjustment_detail" do
    assert_difference('AdjustmentDetail.count') do
      post :create, adjustment_detail: { quatity: @adjustment_detail.quatity }
    end

    assert_redirected_to adjustment_detail_path(assigns(:adjustment_detail))
  end

  test "should show adjustment_detail" do
    get :show, id: @adjustment_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adjustment_detail
    assert_response :success
  end

  test "should update adjustment_detail" do
    put :update, id: @adjustment_detail, adjustment_detail: { quatity: @adjustment_detail.quatity }
    assert_redirected_to adjustment_detail_path(assigns(:adjustment_detail))
  end

  test "should destroy adjustment_detail" do
    assert_difference('AdjustmentDetail.count', -1) do
      delete :destroy, id: @adjustment_detail
    end

    assert_redirected_to adjustment_details_path
  end
end
