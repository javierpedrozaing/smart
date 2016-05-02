require 'test_helper'

class EvaluacionesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get realizadas" do
    get :realizadas
    assert_response :success
  end

  test "should get pendientes" do
    get :pendientes
    assert_response :success
  end

end
