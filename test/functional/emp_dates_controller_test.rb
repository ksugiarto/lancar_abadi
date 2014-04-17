require 'test_helper'

class EmpDatesControllerTest < ActionController::TestCase
  setup do
    @emp_date = emp_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emp_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emp_date" do
    assert_difference('EmpDate.count') do
      post :create, emp_date: { date_order: @emp_date.date_order, total_emp: @emp_date.total_emp, total_top_grade: @emp_date.total_top_grade }
    end

    assert_redirected_to emp_date_path(assigns(:emp_date))
  end

  test "should show emp_date" do
    get :show, id: @emp_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emp_date
    assert_response :success
  end

  test "should update emp_date" do
    put :update, id: @emp_date, emp_date: { date_order: @emp_date.date_order, total_emp: @emp_date.total_emp, total_top_grade: @emp_date.total_top_grade }
    assert_redirected_to emp_date_path(assigns(:emp_date))
  end

  test "should destroy emp_date" do
    assert_difference('EmpDate.count', -1) do
      delete :destroy, id: @emp_date
    end

    assert_redirected_to emp_dates_path
  end
end
