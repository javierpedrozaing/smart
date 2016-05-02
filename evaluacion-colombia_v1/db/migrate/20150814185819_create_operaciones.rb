class CreateOperaciones < ActiveRecord::Migration
  def change
    create_table :operaciones do |t|
      t.integer :tipo_operador_id
      t.integer :operando_izq
      t.integer :operando_der
      t.string :operando_izq_tipo
      t.string :operando_der_tipo
    end
  end
end
