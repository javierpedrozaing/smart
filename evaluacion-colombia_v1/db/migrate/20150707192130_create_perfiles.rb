class CreatePerfiles < ActiveRecord::Migration
  def change
    create_table :perfiles do |t|
      t.string :perfil

      t.timestamps null: false
    end
  end
end
