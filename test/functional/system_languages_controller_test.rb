require 'test_helper'

class SystemLanguagesControllerTest < ActionController::TestCase
  setup do
    @system_language = system_languages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_languages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_language" do
    assert_difference('SystemLanguage.count') do
      post :create, system_language: { active: @system_language.active, initial: @system_language.initial, name: @system_language.name }
    end

    assert_redirected_to system_language_path(assigns(:system_language))
  end

  test "should show system_language" do
    get :show, id: @system_language
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_language
    assert_response :success
  end

  test "should update system_language" do
    put :update, id: @system_language, system_language: { active: @system_language.active, initial: @system_language.initial, name: @system_language.name }
    assert_redirected_to system_language_path(assigns(:system_language))
  end

  test "should destroy system_language" do
    assert_difference('SystemLanguage.count', -1) do
      delete :destroy, id: @system_language
    end

    assert_redirected_to system_languages_path
  end
end
