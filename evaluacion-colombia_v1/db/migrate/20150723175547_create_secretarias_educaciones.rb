class CreateSecretariasEducaciones < ActiveRecord::Migration
  def change
    create_table :secretarias_educaciones do |t|
      t.string :secretaria
      t.integer :region_id
    end
  end
end
