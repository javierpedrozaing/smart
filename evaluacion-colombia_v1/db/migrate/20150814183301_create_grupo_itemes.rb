class CreateGrupoItemes < ActiveRecord::Migration
  def change
    create_table :grupo_itemes do |t|
      t.text  :enunciado
    end
  end
end
