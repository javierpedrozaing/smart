require 'test_helper'

class GrupoItemesControllerTest < ActionController::TestCase
  setup do
    @grupo_item = grupo_itemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grupo_itemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grupo_item" do
    assert_difference('GrupoItem.count') do
      post :create, grupo_item: {  }
    end

    assert_redirected_to grupo_item_path(assigns(:grupo_item))
  end

  test "should show grupo_item" do
    get :show, id: @grupo_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grupo_item
    assert_response :success
  end

  test "should update grupo_item" do
    patch :update, id: @grupo_item, grupo_item: {  }
    assert_redirected_to grupo_item_path(assigns(:grupo_item))
  end

  test "should destroy grupo_item" do
    assert_difference('GrupoItem.count', -1) do
      delete :destroy, id: @grupo_item
    end

    assert_redirected_to grupo_itemes_path
  end
end
