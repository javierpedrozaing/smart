require 'test_helper'

class VideoEstadosControllerTest < ActionController::TestCase
  setup do
    @video_estado = video_estados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:video_estados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create video_estado" do
    assert_difference('VideoEstado.count') do
      post :create, video_estado: { video_estado: @video_estado.video_estado, video_estado_id: @video_estado.video_estado_id }
    end

    assert_redirected_to video_estado_path(assigns(:video_estado))
  end

  test "should show video_estado" do
    get :show, id: @video_estado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @video_estado
    assert_response :success
  end

  test "should update video_estado" do
    patch :update, id: @video_estado, video_estado: { video_estado: @video_estado.video_estado, video_estado_id: @video_estado.video_estado_id }
    assert_redirected_to video_estado_path(assigns(:video_estado))
  end

  test "should destroy video_estado" do
    assert_difference('VideoEstado.count', -1) do
      delete :destroy, id: @video_estado
    end

    assert_redirected_to video_estados_path
  end
end
