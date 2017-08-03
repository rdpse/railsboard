class Item < ApplicationRecord
  include Cambio
  attr_accessor :actualizar_fatura

  belongs_to :cliente, required: false
  belongs_to :fatura, required: false
  belongs_to :produto, required: false
  belongs_to :servico, polymorphic: true, required: false

  after_save :actualizar_fatura!

  def converter_valor(moeda_antiga, moeda_nova)
    # Em caso de conversão, actualizamos tudo de enfiada no final,
    # através do model Fatura
    self.actualizar_fatura = false

    novo_valor = Item.cambio(self.valor, moeda_antiga, moeda_nova)
    update_attribute :valor, novo_valor
  end


  private

    def actualizar_fatura!
      self.fatura.actualizar_valor unless self.actualizar_fatura == false
    end
    
end
