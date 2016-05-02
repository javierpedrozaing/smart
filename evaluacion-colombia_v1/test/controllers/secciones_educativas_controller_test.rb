require 'test_helper'

class SeccionesEducativasControllerTest < ActionController::TestCase
  setup do
    @secciones_educativa = secciones_educativas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secciones_educativas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create secciones_educativa" do
    assert_difference('SeccionesEducativa.count') do
      post :create, secciones_educativa: { descripcion: @secciones_educativa.descripcion }
    end

    assert_redirected_to secciones_educativa_path(assigns(:secciones_educativa))
  end

  test "should show secciones_educativa" do
    get :show, id: @secciones_educativa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @secciones_educativa
    assert_response :success
  end

  test "should update secciones_educativa" do
    patch :update, id: @secciones_educativa, secciones_educativa: { descripcion: @secciones_educativa.descripcion }
    assert_redirected_to secciones_educativa_path(assigns(:secciones_educativa))
  end

  test "should destroy secciones_educativa" do
    assert_difference('SeccionesEducativa.count', -1) do
      delete :destroy, id: @secciones_educativa
    end

    assert_redirected_to secciones_educativas_path
  end
end
