class DropGrillaPregunta < ActiveRecord::Migration

  def up
    drop_table :grilla_preguntas if ActiveRecord::Base.connection.table_exists? 'grilla_preguntas'
  end

  def down
  end
end
