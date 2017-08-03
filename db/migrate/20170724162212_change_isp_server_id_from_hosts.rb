class ChangeIspServerIdFromHosts < ActiveRecord::Migration[5.0]
  change_table :hosts do |t|
    t.change :isp_server_id, :string
  end
end
