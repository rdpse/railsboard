module Cambio
  extend ActiveSupport::Concern

  module ClassMethods
    def cambio(montante, moeda_antiga, moeda_nova)
      fx = OpenExchangeRates::Rates.new
      fx.convert(montante, from: moeda_antiga, to: moeda_nova)
    end
  end
   
end
