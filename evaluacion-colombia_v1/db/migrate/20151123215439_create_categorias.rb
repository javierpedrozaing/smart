class CreateCategorias < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string :codigo
      t.string :nombre

      t.timestamps null: false
    end
  end
  
  def data
    categoria1 = Categoria.create({id: 1, codigo: "ACD", nombre: "ACTIVIDADES DEL DOCENTE" })
    categoria2 = Categoria.create({id: 2, codigo: "ACE", nombre: "ACTIVIDADES DE LOS ESTUDIANTES" })
    categoria3 = Categoria.create({id: 3, codigo: "CDE", nombre: "COMUNICACIÓN" })
    categoria4 = Categoria.create({id: 4, codigo: "CLA", nombre: "CLIMA DE AULA" })
    categoria5 = Categoria.create({id: 5, codigo: "CNV", nombre: "ACUERDOS" })
    categoria6 = Categoria.create({id: 6, codigo: "EVF", nombre: "EVALUACIÓN FORMATIVA" })
    categoria7 = Categoria.create({id: 7, codigo: "MDC", nombre: "ESTRUCTURA GENERAL DE LA CLASE" })
    categoria8 = Categoria.create({id: 8, codigo: "PAT", nombre: "PARTICIPACIÓN" })
    categoria9 = Categoria.create({id: 9, codigo: "URM", nombre: "RECURSOS" }) 
  end
  
  def rollback
  end
end
