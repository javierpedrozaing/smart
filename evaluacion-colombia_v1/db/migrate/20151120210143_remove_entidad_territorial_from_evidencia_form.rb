class RemoveEntidadTerritorialFromEvidenciaForm < ActiveRecord::Migration
  def change
    remove_column :evidencia_formes, :entidad_territorial, :string
  end
end
