class AddCloudlareToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :cloudflare_api_key, :string
    add_column :clientes, :cloudflare_email, :string
  end
end
