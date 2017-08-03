module Faturacao
  extend ActiveSupport::Concern

  def a_vencer?
    (self.vencimento - Date.today).to_i <= 7
  end

  # Host apenas está faturado se houver um item que
  # corresponda à sua data de vencimento
  def fatura_do_mes
    self.faturas.find_by(vencimento: self.vencimento)
  end

  def faturado?
    fatura = fatura_do_mes
    fatura.itens.find_by(servico_id: self.id).present? if fatura.present?
  end

  def criar_fatura_e_item
    # Fatura #
    fatura = self.cliente.faturas.create!(
      vencimento: self.vencimento,
      via_de_pagamento: self.cliente.via_de_pagamento,
      moeda: self.cliente.moeda,
      status: 0
    )

    # Item #
    adicionar_host_fatura(fatura)   
  end

  def adicionar_host_fatura(fatura)
    self.itens.create!(
      cliente_id: self.cliente.id,
      fatura_id: fatura.id,
      produto_id: self.produto.id,
      valor: self.valor,
      quantidade: 1,
      descricao: "#{self.hostname} (#{self.ipv4})"
    )

    fatura.enviar  
  end
end
