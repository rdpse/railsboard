require 'test_helper'

class OperacoesControllerTest < ActionDispatch::IntegrationTest
  test "should get reiniciar" do
    get operacoes_reiniciar_url
    assert_response :success
  end

  test "should get desligar" do
    get operacoes_desligar_url
    assert_response :success
  end

  test "should get limpar_cache" do
    get operacoes_limpar_cache_url
    assert_response :success
  end

  test "should get criar_subdominio" do
    get operacoes_criar_subdominio_url
    assert_response :success
  end

  test "should get criar_email" do
    get operacoes_criar_email_url
    assert_response :success
  end

end
