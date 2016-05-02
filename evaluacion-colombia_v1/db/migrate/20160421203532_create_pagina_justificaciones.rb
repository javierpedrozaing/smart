class CreatePaginaJustificaciones < ActiveRecord::Migration
  def change
    create_table :pagina_justificaciones do |t|
      t.integer :autoevaluacion_id
      t.integer :pagina
      t.string :justificacion, limit: 1000

      t.timestamps null: false
    end
  end
end
