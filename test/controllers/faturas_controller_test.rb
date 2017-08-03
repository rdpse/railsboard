require 'test_helper'

class FaturasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get faturas_index_url
    assert_response :success
  end

  test "should get show" do
    get faturas_show_url
    assert_response :success
  end

end
