class AddNivelParToEvaluador < ActiveRecord::Migration
  def change
    add_column :evaluadores, :nivelpar_id, :integer
    add_index :evaluadores, :nivelpar_id
  end
end
