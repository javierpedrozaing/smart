class CreateTestPreguntas < ActiveRecord::Migration
  def change
    create_table :test_preguntas do |t|
      t.integer :test_id
      t.integer :pregunta_id
    end
  end
end
