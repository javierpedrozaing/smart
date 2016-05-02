class AddCausaToReporte < ActiveRecord::Migration
  def change
    add_column :reportes, :causa, :text
    change_column :reportes, :causa, :text, null: true
  end
end
