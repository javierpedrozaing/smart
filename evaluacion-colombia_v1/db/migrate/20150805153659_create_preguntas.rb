class CreatePreguntas < ActiveRecord::Migration
  def change
    create_table :preguntas do |t|
      t.text :pregunta
      t.references :grilla, index: true, foreign_key: true
    end
  end
end
