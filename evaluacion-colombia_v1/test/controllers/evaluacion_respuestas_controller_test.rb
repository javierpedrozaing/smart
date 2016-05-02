require 'test_helper'

class EvaluacionRespuestasControllerTest < ActionController::TestCase
  setup do
    @evaluacion_respuesta = evaluacion_respuestas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluacion_respuestas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evaluacion_respuesta" do
    assert_difference('EvaluacionRespuesta.count') do
      post :create, evaluacion_respuesta: {  }
    end

    assert_redirected_to evaluacion_respuesta_path(assigns(:evaluacion_respuesta))
  end

  test "should show evaluacion_respuesta" do
    get :show, id: @evaluacion_respuesta
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @evaluacion_respuesta
    assert_response :success
  end

  test "should update evaluacion_respuesta" do
    patch :update, id: @evaluacion_respuesta, evaluacion_respuesta: {  }
    assert_redirected_to evaluacion_respuesta_path(assigns(:evaluacion_respuesta))
  end

  test "should destroy evaluacion_respuesta" do
    assert_difference('EvaluacionRespuesta.count', -1) do
      delete :destroy, id: @evaluacion_respuesta
    end

    assert_redirected_to evaluacion_respuestas_path
  end
end
