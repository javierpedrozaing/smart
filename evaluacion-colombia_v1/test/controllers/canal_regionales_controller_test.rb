require 'test_helper'

class CanalRegionalesControllerTest < ActionController::TestCase
  setup do
    @canal_regional = canal_regionales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:canal_regionales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create canal_regional" do
    assert_difference('CanalRegional.count') do
      post :create, canal_regional: { descripcion: @canal_regional.descripcion }
    end

    assert_redirected_to canal_regional_path(assigns(:canal_regional))
  end

  test "should show canal_regional" do
    get :show, id: @canal_regional
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @canal_regional
    assert_response :success
  end

  test "should update canal_regional" do
    patch :update, id: @canal_regional, canal_regional: { descripcion: @canal_regional.descripcion }
    assert_redirected_to canal_regional_path(assigns(:canal_regional))
  end

  test "should destroy canal_regional" do
    assert_difference('CanalRegional.count', -1) do
      delete :destroy, id: @canal_regional
    end

    assert_redirected_to canal_regionales_path
  end
end
