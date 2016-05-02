class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :test
      t.boolean :validado, default: false
    end
  end
end
