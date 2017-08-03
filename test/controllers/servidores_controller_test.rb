require 'test_helper'

class ServidoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get servidores_index_url
    assert_response :success
  end

  test "should get show" do
    get servidores_show_url
    assert_response :success
  end

end
