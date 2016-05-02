class CreateTestPersonas < ActiveRecord::Migration
  def change
    create_table :test_personas do |t|
      t.integer :evaluado_id
      t.integer :evaluador_id
      t.integer :test_id
    end
  end
end
