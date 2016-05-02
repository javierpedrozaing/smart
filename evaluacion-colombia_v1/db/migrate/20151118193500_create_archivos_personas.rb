class CreateArchivosPersonas < ActiveRecord::Migration
  def change
    create_table :archivos_personas do |t|
      t.integer :persona_id
      t.integer :tipo
    end
  end
end
