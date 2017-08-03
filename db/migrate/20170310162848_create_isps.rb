class CreateIsps < ActiveRecord::Migration[5.0]
  def change
    create_table :isps do |t|
      t.string :nome
      t.string :sigla
      t.text :api_url
      t.string :api_sk
      t.string :api_pk

      t.timestamps
    end
  end
end
