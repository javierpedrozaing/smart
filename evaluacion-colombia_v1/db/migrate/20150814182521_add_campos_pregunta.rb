class AddCamposPregunta < ActiveRecord::Migration
  def change
    add_column :preguntas, :tipo_pregunta_id, :integer
    add_column :preguntas, :validada, :boolean
    add_column :preguntas, :enunciado, :text
    add_column :preguntas, :explicacion, :text
    add_column :preguntas, :grupo_item_id, :integer
  end
end
