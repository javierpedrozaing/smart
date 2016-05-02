class CreateCoordinadores < ActiveRecord::Migration
  def change
    create_table :coordinadores do |t|
      t.references :estado, index: true, foreign_key: true
      t.references :persona, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
