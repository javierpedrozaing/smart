class DropUsuariosTable < ActiveRecord::Migration
  def up
  	drop_table :usuarios
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
