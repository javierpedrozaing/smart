class CreateValoraciones < ActiveRecord::Migration
  def change
    create_table :valoraciones do |t|
      t.integer :pregunta_id
    end
  end
end
