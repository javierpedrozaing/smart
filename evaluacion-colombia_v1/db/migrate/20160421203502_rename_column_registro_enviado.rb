class RenameColumnRegistroEnviado < ActiveRecord::Migration
  def change
  	rename_column :autoevaluacion_respuestas ,:registro_enviado, :pagina
  end
end
