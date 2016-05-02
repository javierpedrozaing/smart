class AddFechaInicialToPeriodoGrillas < ActiveRecord::Migration
  def change
    add_column :periodo_grillas, :fecha_inicial, :date
  end
end
