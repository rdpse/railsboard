module FaturasHelper
  def lista_itens(fatura)
    return 'Nenhum serviço associado.' if fatura.itens.empty?
    if fatura.itens.count == 1
      item = fatura.itens.last.descricao
    else
      itens = ''
      fatura.itens.find_each do |i|
        itens << i.descricao + ", "
      end
      itens.chomp!(", ") # Remove trailing comma
      return itens
    end
  end

  def cambio(moeda)
    if moeda == "BRL"
      "R$ "
    elsif moeda == "EUR"
      "€ "
    end
  end

  def valor_formatado(moeda, valor)
    cambio(moeda) + valor.to_s
  end
end
