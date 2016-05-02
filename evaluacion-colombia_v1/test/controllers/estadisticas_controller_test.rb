require 'test_helper'

class EstadisticasControllerTest < ActionController::TestCase
  test "should get admin_evaluador" do
    get :admin_evaluador
    assert_response :success
  end

end
