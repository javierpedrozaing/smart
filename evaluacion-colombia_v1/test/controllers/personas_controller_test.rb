require 'test_helper'

class PersonasControllerTest < ActionController::TestCase
  setup do
    @persona = personas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create persona" do
    assert_difference('Persona.count') do
      post :create, persona: { apellido_materno: @persona.apellido_materno, apellido_paterno: @persona.apellido_paterno, celular: @persona.celular, direccion: @persona.direccion, documento: @persona.documento, email: @persona.email, nombre: @persona.nombre, telefono: @persona.telefono, tipo_documento_id: @persona.tipo_documento_id }
    end

    assert_redirected_to persona_path(assigns(:persona))
  end

  test "should show persona" do
    get :show, id: @persona
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @persona
    assert_response :success
  end

  test "should update persona" do
    patch :update, id: @persona, persona: { apellido_materno: @persona.apellido_materno, apellido_paterno: @persona.apellido_paterno, celular: @persona.celular, direccion: @persona.direccion, documento: @persona.documento, email: @persona.email, nombre: @persona.nombre, telefono: @persona.telefono, tipo_documento_id: @persona.tipo_documento_id }
    assert_redirected_to persona_path(assigns(:persona))
  end

  test "should destroy persona" do
    assert_difference('Persona.count', -1) do
      delete :destroy, id: @persona
    end

    assert_redirected_to personas_path
  end
end
