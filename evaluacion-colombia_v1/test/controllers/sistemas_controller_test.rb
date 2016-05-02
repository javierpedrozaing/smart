require 'test_helper'

class SistemasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
