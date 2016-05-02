require 'test_helper'

class UsuariosControllerTest < ActionController::TestCase
  test "should get camarografos" do
    get :camarografos
    assert_response :success
  end

  test "should get evaluadores" do
    get :evaluadores
    assert_response :success
  end

  test "should get profesores" do
    get :profesores
    assert_response :success
  end

  test "should get coordinadores" do
    get :coordinadores
    assert_response :success
  end

  test "should get jefe_evaluacion" do
    get :jefe_evaluacion
    assert_response :success
  end

  test "should get jefe_camarografos" do
    get :jefe_camarografos
    assert_response :success
  end

  test "should get jefe_evaluadores" do
    get :jefe_evaluadores
    assert_response :success
  end

  test "should get administradores" do
    get :administradores
    assert_response :success
  end

end
