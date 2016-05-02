require 'test_helper'

class GrillasControllerTest < ActionController::TestCase
  setup do
    @grilla = grillas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grillas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grilla" do
    assert_difference('Grilla.count') do
      post :create, grilla: { asignatura_id: @grilla.asignatura_id, grilla: @grilla.grilla, seccion_educativa_id: @grilla.seccion_educativa_id }
    end

    assert_redirected_to grilla_path(assigns(:grilla))
  end

  test "should show grilla" do
    get :show, id: @grilla
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grilla
    assert_response :success
  end

  test "should update grilla" do
    patch :update, id: @grilla, grilla: { asignatura_id: @grilla.asignatura_id, grilla: @grilla.grilla, seccion_educativa_id: @grilla.seccion_educativa_id }
    assert_redirected_to grilla_path(assigns(:grilla))
  end

  test "should destroy grilla" do
    assert_difference('Grilla.count', -1) do
      delete :destroy, id: @grilla
    end

    assert_redirected_to grillas_path
  end
end
