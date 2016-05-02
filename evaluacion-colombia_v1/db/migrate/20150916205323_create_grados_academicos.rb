class CreateGradosAcademicos < ActiveRecord::Migration
  def change
    create_table :grados_academicos do |t|
      t.string :nombre
      t.integer :rango
    end
  end
end
