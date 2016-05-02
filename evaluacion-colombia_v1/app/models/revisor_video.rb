class RevisorVideo < ActiveRecord::Base
  belongs_to :estado_revision_video
  belongs_to :persona, foreign_key: "revisor_id"
  belongs_to :video, foreign_key: "video_id"

  def self.create_entry estado, video_id
    @revisor = RevisorVideo.new
    @revisor.estado = estado
    @revisor.video_id = video_id
    @revisor.revisor_id = find_revisor
    @revisor.save
  end

  def self.find_revisor
    if Persona.revisores.blank?
      nil
    else
      ##Persona.revisores.first.id
      aux=Persona.first
      val=100000
      Persona.revisores.each do |revisor|
        if revisor.videos_por_revisar < val
          aux=revisor
          val=revisor.videos_por_revisar
        end
      end
      aux.id
    end
  end
end
