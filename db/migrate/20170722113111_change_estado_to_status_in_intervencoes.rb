class ChangeEstadoToStatusInIntervencoes < ActiveRecord::Migration[5.0]
  def change
    rename_column :intervencoes, :estado, :status
  end
end
