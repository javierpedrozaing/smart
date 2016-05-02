require 'test_helper'

class TutorialesControllerTest < ActionController::TestCase
  setup do
    @tutorial = tutoriales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tutoriales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tutorial" do
    assert_difference('Tutorial.count') do
      post :create, tutorial: { pagina_id: @tutorial.pagina_id, perfil_id: @tutorial.perfil_id, tutorial: @tutorial.tutorial, youtube_id: @tutorial.youtube_id }
    end

    assert_redirected_to tutorial_path(assigns(:tutorial))
  end

  test "should show tutorial" do
    get :show, id: @tutorial
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tutorial
    assert_response :success
  end

  test "should update tutorial" do
    patch :update, id: @tutorial, tutorial: { pagina_id: @tutorial.pagina_id, perfil_id: @tutorial.perfil_id, tutorial: @tutorial.tutorial, youtube_id: @tutorial.youtube_id }
    assert_redirected_to tutorial_path(assigns(:tutorial))
  end

  test "should destroy tutorial" do
    assert_difference('Tutorial.count', -1) do
      delete :destroy, id: @tutorial
    end

    assert_redirected_to tutoriales_path
  end
end
