require 'test_helper'

class EmpDateDetailsControllerTest < ActionController::TestCase
  setup do
    @emp_date_detail = emp_date_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emp_date_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emp_date_detail" do
    assert_difference('EmpDateDetail.count') do
      post :create, emp_date_detail: {  }
    end

    assert_redirected_to emp_date_detail_path(assigns(:emp_date_detail))
  end

  test "should show emp_date_detail" do
    get :show, id: @emp_date_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emp_date_detail
    assert_response :success
  end

  test "should update emp_date_detail" do
    put :update, id: @emp_date_detail, emp_date_detail: {  }
    assert_redirected_to emp_date_detail_path(assigns(:emp_date_detail))
  end

  test "should destroy emp_date_detail" do
    assert_difference('EmpDateDetail.count', -1) do
      delete :destroy, id: @emp_date_detail
    end

    assert_redirected_to emp_date_details_path
  end
end
