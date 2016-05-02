class CreateTutoriales < ActiveRecord::Migration
  def change
    create_table :tutoriales do |t|
      t.string :tutorial
      t.string :youtube_id
      t.integer :pagina_id
      t.integer :perfil_id

      t.timestamps null: false
    end
  end
end
