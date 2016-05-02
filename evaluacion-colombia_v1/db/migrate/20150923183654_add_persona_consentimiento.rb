class AddPersonaConsentimiento < ActiveRecord::Migration
  def change
    add_column :personas, :consentimiento, :boolean
  end
end
