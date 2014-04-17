require 'test_helper'

class EmpMonthsControllerTest < ActionController::TestCase
  setup do
    @emp_month = emp_months(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emp_months)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emp_month" do
    assert_difference('EmpMonth.count') do
      post :create, emp_month: { month_order: @emp_month.month_order, year: @emp_month.year }
    end

    assert_redirected_to emp_month_path(assigns(:emp_month))
  end

  test "should show emp_month" do
    get :show, id: @emp_month
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emp_month
    assert_response :success
  end

  test "should update emp_month" do
    put :update, id: @emp_month, emp_month: { month_order: @emp_month.month_order, year: @emp_month.year }
    assert_redirected_to emp_month_path(assigns(:emp_month))
  end

  test "should destroy emp_month" do
    assert_difference('EmpMonth.count', -1) do
      delete :destroy, id: @emp_month
    end

    assert_redirected_to emp_months_path
  end
end
