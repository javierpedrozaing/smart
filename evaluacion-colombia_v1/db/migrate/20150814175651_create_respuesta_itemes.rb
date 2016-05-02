class CreateRespuestaItemes < ActiveRecord::Migration
  def change
    create_table :respuesta_itemes do |t|
      t.integer :item_id
      t.integer :test_instancia_id
    end
  end
end
