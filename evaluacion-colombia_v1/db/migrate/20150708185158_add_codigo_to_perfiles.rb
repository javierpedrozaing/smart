class AddCodigoToPerfiles < ActiveRecord::Migration
  def change
    add_column :perfiles, :codigo, :string
  end
end
