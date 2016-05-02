class AddAttachmentToPersona < ActiveRecord::Migration
  def up
    add_attachment :archivos_personas, :archivo
  end

  def down
    add_attachment :archivos_personas, :archivo
  end
  
end
