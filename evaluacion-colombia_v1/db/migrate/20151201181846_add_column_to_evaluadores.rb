class AddColumnToEvaluadores < ActiveRecord::Migration
  def change
    add_column :evaluadores, :departamento_id, :integer
  end
end
