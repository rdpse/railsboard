class ProdutosController < ApplicationController
  skip_before_action :login_obrigatorio, :set_hosts
  layout "produtos"

  def index
    @produtos = Produto.order('valor ASC').where.not(mostrar: false)
  end
end
