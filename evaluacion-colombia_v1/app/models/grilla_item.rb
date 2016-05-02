class GrillaItem < ActiveRecord::Base
  belongs_to :grilla
  belongs_to :categoria


  validates_associated :grilla
  validates_associated :categoria
  validates :cod_item, 
            :presence => true,
            format: { with: /\d{5}/, message: "solo permite números de 5 dígitos" }
  validates :cod_dimension, 
            :presence => true,
            format: { with: /\d{5}/, message: "solo permite números de 5 dígitos" }
  validates :cod_sub_dimension, 
            :presence => true,
            format: { with: /\d{5}/, message: "solo permite números de 5 dígitos" }
  validates :cod_afirmacion, 
            :presence => true,
            format: { with: /\d{5}/, message: "solo permite números de 5 dígitos" }
  validates :cod_evidencia, 
            :presence => true,
            format: { with: /\d{5}/, message: "solo permite números de 5 dígitos" }
  validates :item, :presence => true
  validates :escala, :presence => true
  validates :orden_item, 
            :presence => true,
            :numericality => { :greater_than => 0, :less_than_or_equal_to => 99 }
            # format: { with: /\d{1,2}/, message: "solo permite números de 1 a 2 dígitos" }
  validates :ejemplos, :presence => true

  def self.tipos_escala
    ["est1", "est2", "est3", "sino", "sinona"]
  end 

  validates :escala, 
    inclusion: { :in => GrillaItem.tipos_escala ,
    message: "no es una escala valida" }

  
end
