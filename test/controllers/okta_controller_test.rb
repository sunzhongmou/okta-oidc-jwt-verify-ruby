require 'test_helper'

class OktaControllerTest < ActionDispatch::IntegrationTest
  test "should get hello" do
    get okta_hello_url
    assert_response :success
  end

end
