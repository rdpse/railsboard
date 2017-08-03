class Dominio < ApplicationRecord
  belongs_to :cliente, required: false
  belongs_to :host, required: false
end
