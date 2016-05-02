require 'test_helper'

class LogesControllerTest < ActionController::TestCase
  setup do
    @log = loges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create log" do
    assert_difference('Log.count') do
      post :create, log: { log: @log.log, modulos_id: @log.modulos_id, usuarios_id: @log.usuarios_id }
    end

    assert_redirected_to log_path(assigns(:log))
  end

  test "should show log" do
    get :show, id: @log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @log
    assert_response :success
  end

  test "should update log" do
    patch :update, id: @log, log: { log: @log.log, modulos_id: @log.modulos_id, usuarios_id: @log.usuarios_id }
    assert_redirected_to log_path(assigns(:log))
  end

  test "should destroy log" do
    assert_difference('Log.count', -1) do
      delete :destroy, id: @log
    end

    assert_redirected_to loges_path
  end
end
