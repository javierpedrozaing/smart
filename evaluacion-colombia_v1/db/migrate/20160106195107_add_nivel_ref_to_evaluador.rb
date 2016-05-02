class AddNivelRefToEvaluador < ActiveRecord::Migration
  def change
    add_reference :evaluadores, :nivel, index: true, foreign_key: true
  end
end
