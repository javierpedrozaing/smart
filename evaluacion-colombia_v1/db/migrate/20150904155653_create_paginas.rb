class CreatePaginas < ActiveRecord::Migration
  def change
    create_table :paginas do |t|
      t.string :controller
      t.string :action

      t.timestamps null: false
    end
  end
end
