class CreateEvidenciaFormes < ActiveRecord::Migration
  def change
    create_table :evidencia_formes do |t|
      t.integer :profesor_id
      t.string :departamento, :null => false
      t.string :municipio, :null => false
      t.string :entidad_territorial, :null => false
      t.string :cargo, :null => false
      t.string :ultimo_nivel_educativo
      t.string :nivel
      t.string :area, :null => false
      t.string :grado, :null => false
      t.string :modelo_educativo, :null => false
      t.string :tiempo_laborado_institucion
      t.string :tiempo_docente_estudiantes
      t.integer :numero_estudiantes, :null => false
      t.integer :numero_estudiantes_consentimiento, :null => false
      t.datetime :fecha_clase_grabada, :null => true
      t.string :desarrollo_tematico
      t.text :propositos_objetivos
      t.text :relacion_planes
      t.text :planeacion_pei
      t.text :organizacion_contenidos
      t.text :planeacion_aspectos_criterios
      t.text :materiales_recursos
      t.text :evaluacion_retroalimentacion_clase
      t.text :metodologias_estrategias_empleadas

      t.timestamps null: false
    end
  end
end
