module TutorialesHelper
 #Creacion de iframe para presentacion del videotutorial 
  def embed(youtube_url)
    if youtube_url.blank? == false
      youtube_id = youtube_url.split("=").last
      content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
    end
  end
  #Buscamos el video segun el prefil de usuario 
  def cosulta_tutorial(usuario, controller, action) 
     
    url = Tutorial.joins(:pagina).where(:perfil_id=>Persona.joins(:rol=>:perfiles).
          where(:id=>usuario).pluck('perfiles.id'),'paginas.controller'=>controller,'paginas.action'=>action).
          pluck(:youtube_id).first  
                                           
    return embed(url)      
  end  
end
