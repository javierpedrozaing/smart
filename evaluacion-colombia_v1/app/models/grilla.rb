class Grilla < ActiveRecord::Base
  belongs_to :cargo
  has_one :pregunta
  has_many :grilla_preguntas
  has_many :grilla_item
  has_one :grilla_autoevaluacion
  has_one :periodo_grilla
  
 
  def self.itemsOrdenados(grilla_id)
    GrillaItem.where(grilla_id: grilla_id).order(:categoria_id,:orden_item)
  end
  def self.itemsOrdenadosAutoevalaucion(grilla_id)
    GrillaAutoevaluacion.where(grilla_id: grilla_id).order(:posicion)
  end

  def generarPreguntasPrueba

    g = Grilla.find(self.id)
    item = GrillaItem.create( grilla: g,
                              cod_item: "10132",
                              categoria: Categoria.find_by(codigo: "ACD"),
                              cod_dimension: "00001", 
                              cod_sub_dimension: "00010",
                              cod_afirmacion: "00200",
                              cod_evidencia: "02100",
                              item: "Fulana no muchas de percal yo antojo",
                              escala: "sino",
                              orden_item: 1,
                              ejemplos: "ejemplo")

    item = GrillaItem.create( grilla: g,
                              cod_item: "10121",
                              categoria: Categoria.find_by(codigo: "ACE"),
                              cod_dimension: "00001", 
                              cod_sub_dimension: "00010",
                              cod_afirmacion: "00200",
                              cod_evidencia: "02100",
                              item: "Zaga uno fija aca pano ama hoy est1",
                              escala: "sino",
                              orden_item: 1,
                              ejemplos: "ejemplo")

    item = GrillaItem.create( grilla: g,
                              cod_item: "10016",
                              categoria: Categoria.find_by(codigo: "CDE"),
                              cod_dimension: "30000", 
                              cod_sub_dimension: "31000",
                              cod_afirmacion: "31120",
                              cod_evidencia: "31120",
                              item: "Zaga uno fija aca pano ama hoy est1",
                              escala: "sino",
                              orden_item: 1,
                              ejemplos: "ejemplo")

    item = GrillaItem.create( grilla: g,
                              cod_item: "10042",
                              categoria: Categoria.find_by(codigo: "CLA"),
                              cod_dimension: "40000", 
                              cod_sub_dimension: "42000",
                              cod_afirmacion: "42100",
                              cod_evidencia: "42120",
                              item: "Zaga uno fija aca pano ama hoy est1",
                              escala: "sino",
                              orden_item: 1,
                              ejemplos: "ejemplo")

  end

end
