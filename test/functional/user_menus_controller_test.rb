require 'test_helper'

class UserMenusControllerTest < ActionController::TestCase
  setup do
    @user_menu = user_menus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_menus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_menu" do
    assert_difference('UserMenu.count') do
      post :create, user_menu: { header_id: @user_menu.header_id, name: @user_menu.name, sub_header_id: @user_menu.sub_header_id, url: @user_menu.url, visible: @user_menu.visible }
    end

    assert_redirected_to user_menu_path(assigns(:user_menu))
  end

  test "should show user_menu" do
    get :show, id: @user_menu
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_menu
    assert_response :success
  end

  test "should update user_menu" do
    put :update, id: @user_menu, user_menu: { header_id: @user_menu.header_id, name: @user_menu.name, sub_header_id: @user_menu.sub_header_id, url: @user_menu.url, visible: @user_menu.visible }
    assert_redirected_to user_menu_path(assigns(:user_menu))
  end

  test "should destroy user_menu" do
    assert_difference('UserMenu.count', -1) do
      delete :destroy, id: @user_menu
    end

    assert_redirected_to user_menus_path
  end
end
