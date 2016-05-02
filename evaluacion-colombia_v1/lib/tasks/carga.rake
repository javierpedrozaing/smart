namespace :carga do
  desc "Carga un usuario administrador"
  task usuario_admin: :environment do
    persona = Persona.where(documento: "777777").first
    persona.password = "ascenso2015.!"
    persona.password_confirmation = "ascenso2015.!"
    persona.save
    puts "Se cambio el password del admin"
  end

  desc "Carga profesores de test"
  task test_profesores: :environment do
  end

end
