class EstadoEvaluacion < ActiveRecord::Base
  has_many :evaluaciones

  scope :terminada, -> {where(estado: "Terminada")}
  scope :pendiente, -> {where(estado: "Pendiente")}
  scope :procesando, -> {where(estado: "En proceso")}
  
  scope :sin_completar, -> { where(estado: ["En Proceso", "Pendiente"]) }
end
