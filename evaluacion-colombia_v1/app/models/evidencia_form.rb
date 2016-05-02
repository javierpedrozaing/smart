class EvidenciaForm < ActiveRecord::Base
  validates :cargo, :area, :grado, :modelo_educativo, :numero_estudiantes, :numero_estudiantes_consentimiento, presence: true
  belongs_to :profesor
end
