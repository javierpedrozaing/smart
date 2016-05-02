class Reporte < ActiveRecord::Base

  attr_accessor( :reporte_imagen, :reporte_audio)

  has_many :videos
  has_many :personas
  
  belongs_to :video
  belongs_to :tipos_reporte
  belongs_to :persona
  
  validate :al_menos_uno

  def al_menos_uno
    p self.reporte_imagen
    if reporte_imagen == "0" && reporte_audio == "0"
      errors.add(:tipo_reportes_id,"asdf")
    end
  end
end
