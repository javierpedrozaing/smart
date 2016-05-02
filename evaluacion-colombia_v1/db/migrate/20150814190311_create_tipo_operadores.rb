class CreateTipoOperadores < ActiveRecord::Migration
  def change
    create_table :tipo_operadores do |t|
      t.string :operador
      t.text :descripcion
      t.string :codigo
    end
  end
end
