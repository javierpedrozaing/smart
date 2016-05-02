require 'test_helper'

class IcfesRegistrosControllerTest < ActionController::TestCase
  setup do
    @icfes_registro = icfes_registros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:icfes_registros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create icfes_registro" do
    assert_difference('IcfesRegistro.count') do
      post :create, icfes_registro: { persona_id: @icfes_registro.persona_id, pin: @icfes_registro.pin }
    end

    assert_redirected_to icfes_registro_path(assigns(:icfes_registro))
  end

  test "should show icfes_registro" do
    get :show, id: @icfes_registro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @icfes_registro
    assert_response :success
  end

  test "should update icfes_registro" do
    patch :update, id: @icfes_registro, icfes_registro: { persona_id: @icfes_registro.persona_id, pin: @icfes_registro.pin }
    assert_redirected_to icfes_registro_path(assigns(:icfes_registro))
  end

  test "should destroy icfes_registro" do
    assert_difference('IcfesRegistro.count', -1) do
      delete :destroy, id: @icfes_registro
    end

    assert_redirected_to icfes_registros_path
  end
end
