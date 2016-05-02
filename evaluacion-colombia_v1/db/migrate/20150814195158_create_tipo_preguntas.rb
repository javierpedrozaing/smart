class CreateTipoPreguntas < ActiveRecord::Migration
  def change
    create_table :tipo_preguntas do |t|
      t.string :tipo_pregunta
    end
  end
end
