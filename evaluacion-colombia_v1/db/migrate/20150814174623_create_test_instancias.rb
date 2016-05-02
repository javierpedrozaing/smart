class CreateTestInstancias < ActiveRecord::Migration
  def change
    create_table :test_instancias do |t|
      t.integer :test_persona_id
      t.integer :respuesta_item_id
    end
  end
end
