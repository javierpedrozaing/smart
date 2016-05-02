class AddOrdenToEvaluacion < ActiveRecord::Migration
  def change
    add_column :evaluaciones, :orden, :integer
  end
end
