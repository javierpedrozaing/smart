class DropGrillaAlternativas < ActiveRecord::Migration

  def up
    drop_table :grilla_alternativas if ActiveRecord::Base.connection.table_exists? 'grilla_alternativas'
  end

  def down
  end
end
