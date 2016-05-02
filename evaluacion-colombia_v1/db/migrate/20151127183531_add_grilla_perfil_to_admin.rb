class AddGrillaPerfilToAdmin < ActiveRecord::Migration
  def up
    # El administrador tendrá los permisos de grilla por defecto
    p1 = Perfil.create({perfil: 'Listar Grilla', codigo: 'listar_grilla'})
    p2 = Perfil.create({perfil: 'Ver Grilla', codigo: 'ver_grilla'})
    p3 = Perfil.create({perfil: 'Nueva Grilla', codigo: 'nueva_grilla'})
    p4 = Perfil.create({perfil: 'Editar Grilla', codigo: 'editar_grilla'})
    p5 = Perfil.create({perfil: 'Crear Grilla', codigo: 'crear_grilla'})
    p6 = Perfil.create({perfil: 'Actualizar Grilla', codigo: 'actualizar_grilla'})
    p7 = Perfil.create({perfil: 'Destruir Grilla', codigo: 'destruir_grilla'})

    admin_rol = Rol.find_by(rol: "Administrador")
    admin_rol.perfiles.push(p1)
    admin_rol.perfiles.push(p2)
    admin_rol.perfiles.push(p3)
    admin_rol.perfiles.push(p4)
    admin_rol.perfiles.push(p5)
    admin_rol.perfiles.push(p6)
    admin_rol.perfiles.push(p7)
    admin_rol.save
  end

  def down
    Perfil.find_by( codigo: 'listar_grilla' ).destroy
    Perfil.find_by( codigo: 'ver_grilla' ).destroy
    Perfil.find_by( codigo: 'nueva_grilla' ).destroy
    Perfil.find_by( codigo: 'editar_grilla' ).destroy
    Perfil.find_by( codigo: 'crear_grilla' ).destroy
    Perfil.find_by( codigo: 'actualizar_grilla' ).destroy
    Perfil.find_by( codigo: 'destruir_grilla' ).destroy
  end
end
