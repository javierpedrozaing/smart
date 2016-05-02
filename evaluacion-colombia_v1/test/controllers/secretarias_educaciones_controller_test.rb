require 'test_helper'

class SecretariasEducacionesControllerTest < ActionController::TestCase
  setup do
    @secretarias_educacion = secretarias_educaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secretarias_educaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create secretarias_educacion" do
    assert_difference('SecretariasEducacion.count') do
      post :create, secretarias_educacion: { descripcion: @secretarias_educacion.descripcion }
    end

    assert_redirected_to secretarias_educacion_path(assigns(:secretarias_educacion))
  end

  test "should show secretarias_educacion" do
    get :show, id: @secretarias_educacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @secretarias_educacion
    assert_response :success
  end

  test "should update secretarias_educacion" do
    patch :update, id: @secretarias_educacion, secretarias_educacion: { descripcion: @secretarias_educacion.descripcion }
    assert_redirected_to secretarias_educacion_path(assigns(:secretarias_educacion))
  end

  test "should destroy secretarias_educacion" do
    assert_difference('SecretariasEducacion.count', -1) do
      delete :destroy, id: @secretarias_educacion
    end

    assert_redirected_to secretarias_educaciones_path
  end
end
