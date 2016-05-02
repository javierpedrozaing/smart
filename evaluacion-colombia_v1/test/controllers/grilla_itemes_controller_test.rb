require 'test_helper'

class GrillaItemesControllerTest < ActionController::TestCase
  setup do
    @grilla_item = grilla_itemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grilla_itemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grilla_item" do
    assert_difference('GrillaItem.count') do
      post :create, grilla_item: { categoria_id: @grilla_item.categoria_id, cod_afirmacion: @grilla_item.cod_afirmacion, cod_dimension: @grilla_item.cod_dimension, cod_evidencia: @grilla_item.cod_evidencia, cod_item: @grilla_item.cod_item, cod_sub_dimension: @grilla_item.cod_sub_dimension, ejemplos: @grilla_item.ejemplos, escala: @grilla_item.escala, grilla_id: @grilla_item.grilla_id, item: @grilla_item.item, orden_item: @grilla_item.orden_item }
    end

    assert_redirected_to grilla_item_path(assigns(:grilla_item))
  end

  test "should show grilla_item" do
    get :show, id: @grilla_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grilla_item
    assert_response :success
  end

  test "should update grilla_item" do
    patch :update, id: @grilla_item, grilla_item: { categoria_id: @grilla_item.categoria_id, cod_afirmacion: @grilla_item.cod_afirmacion, cod_dimension: @grilla_item.cod_dimension, cod_evidencia: @grilla_item.cod_evidencia, cod_item: @grilla_item.cod_item, cod_sub_dimension: @grilla_item.cod_sub_dimension, ejemplos: @grilla_item.ejemplos, escala: @grilla_item.escala, grilla_id: @grilla_item.grilla_id, item: @grilla_item.item, orden_item: @grilla_item.orden_item }
    assert_redirected_to grilla_item_path(assigns(:grilla_item))
  end

  test "should destroy grilla_item" do
    assert_difference('GrillaItem.count', -1) do
      delete :destroy, id: @grilla_item
    end

    assert_redirected_to grilla_itemes_path
  end
end
