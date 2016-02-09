require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "should get popular" do
    get :popular
    assert_response :success
  end

end
