class AddStatusToHosts < ActiveRecord::Migration[5.0]
  def change
    add_column :hosts, :status, :integer, default: 0
  end
end
