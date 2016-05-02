class EstadoRevisionVideo < ActiveRecord::Base
  has_one :revisor_video, foreign_key: "estado"

  def self.PENDIENTE
    EstadoRevisionVideo.where(nombre: 'Pendiente').first.id
  end

  def self.APROBADO
    EstadoRevisionVideo.where(nombre: 'Aprobado').first.id
  end

  def self.REPORTADO
    EstadoRevisionVideo.where(nombre: 'Reportado').first.id
  end
  
end
