class ProdutoAdicional < ApplicationRecord
  has_and_belongs_to_many :produtos, required: false
  has_many :adicionais
end
