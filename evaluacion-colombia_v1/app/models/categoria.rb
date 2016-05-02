class Categoria < ActiveRecord::Base

  def select_string
    "(" + self.codigo + ") " + self.nombre
  end
end
