class PeriodoGrilla < ActiveRecord::Base
  belongs_to :grilla
  has_one :autoevaluacion
  belongs_to :profesor
end
