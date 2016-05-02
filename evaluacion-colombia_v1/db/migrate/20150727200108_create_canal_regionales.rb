class CreateCanalRegionales < ActiveRecord::Migration
  def change
    create_table :canal_regionales do |t|
      t.string :canal

      t.timestamps null: false
    end
  end
end
