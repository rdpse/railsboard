class FaturaMailer < ApplicationMailer
  helper :faturas

  default from: "EliteBox Geral <geral@elitebox.com.br>",
          sender: 'geral@elitebox.com.br', 
          'Message-ID': "<#{SecureRandom.uuid}@elitebox.com.br>"

  def nova_fatura(fatura)
    set_vars fatura

    @itens = fatura.itens.all

    mail to: "#{@cliente.nome} <#{@cliente.email}>",
         subject: "Lançamento de Cobrança"
  end

  def lembrete(fatura)
    set_vars fatura

    mail to: "#{@cliente.nome} <#{@cliente.email}>",
         subject: "Lembrete de Pagamento"
  end

  def confirmacao(fatura)
    set_vars fatura

    @assunto = "Confirmação de Pagamento"

    mail to: "#{@cliente.nome} <#{@cliente.email}>",
         subject: @assunto
  end
   

  private

  def set_vars(fatura)
    @cliente = fatura.cliente
    @fatura_id = fatura.id

    @data_emissao = fatura.created_at.to_date.to_s.gsub("-","/")
    @vencimento = fatura.vencimento.strftime("%Y/%m/%d")

    @valor = fatura.valor
    @moeda = fatura.moeda
    @via = fatura.via_de_pagamento
  end

 
end
