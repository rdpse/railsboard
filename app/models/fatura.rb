class Fatura < ApplicationRecord
  include Cambio

  belongs_to :cliente, required: false
  has_many :itens, dependent: :destroy
  has_many :produtos, through: :itens

  enum moeda: [:BRL, :EUR]
  enum via_de_pagamento: [:CC, :TB]
  enum status: [:em_aberto, :cancelada, :parcialmente_paga, :paga]

  after_save :actualizar_valor_itens, if: -> { moeda_changed? and (valor != 0 or !valor.nil?) }
  after_save :actualizar_vencimento_e_notificar, if: -> { status_changed? && self.paga? }


  def pagar_stripe(email, card_token)
    cliente = Stripe::Customer.create email: email,
                                      source: card_token

    Stripe::Charge.create customer: cliente.id,
                          amount: valor_em_centimos(valor_em_euros),
                          description: "ELITEBOX - Fatura ##{self.id}",
                          currency: 'eur' 

  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error: #{e.message}"
    errors.add :base, "Problema com o cartão de crédito."
    false
  end

  # if parcialmente paga, actualizar apenas o item pago / fatura = parcialmente paga
  def actualizar_vencimento_e_notificar
    self.itens.find_each do |i|
      if i.servico.present?
        i.servico.update_attribute :vencimento, 1.month.from_now.to_date
      end
    end
    changes_applied
    enviar_confirmacao_de_pagamento
  end

  def valor_em_euros
    return self.valor if self.EUR?
    Fatura.cambio(self.valor, "BRL", "EUR")       
  end

  def valor_em_centimos(valor_decimal)
    valor_decimal *= 100
    valor_decimal.to_i
  end

  def actualizar_valor
    self.valor = 0
    self.itens.find_each do |i|
      self.valor += i.valor
    end
    save!
  end

  def enviar
    # Vamos certificar-nos de que o valor total está actualizado
    actualizar_valor  
    FaturaMailer.nova_fatura(self).deliver_now
  end

  def enviar_confirmacao_de_pagamento
    FaturaMailer.confirmacao(self).deliver_now
  end


  private

    def actualizar_valor_itens
      self.itens.find_each do |i|
        i.converter_valor(self.moeda_was, self.moeda)
      end

      # Passamos a considerar a alteração de moeda como uma 
      # alteração que já aconteceu, evitando que o loop se repita
      changes_applied  
      actualizar_valor
    end

end
