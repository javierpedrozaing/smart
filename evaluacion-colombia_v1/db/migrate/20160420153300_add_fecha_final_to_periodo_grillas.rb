class AddFechaFinalToPeriodoGrillas < ActiveRecord::Migration
  def change
    add_column :periodo_grillas, :fecha_final, :date
  end
end
