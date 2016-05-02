class Funciones::Utilidades
  def initialize
  end

  def self.format_time_spanish time
    days = ["Enero", "Febrero","Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    day = time.day.to_s
    month = days[time.month - 1]
    year = time.year.to_s
    date_string = day + " días del mes de " + month + " del " + year
    date_string
  end
end