class ChangeTypeGrillaTipoGrilla < ActiveRecord::Migration
  def up
    change_table :grillas do |t|
      t.change :tipo_grilla, :string 
  end
 end
  def down
    change_table :grillas do |t|
      t.change :tipo_grilla, :integer
    
    end
  end
end
