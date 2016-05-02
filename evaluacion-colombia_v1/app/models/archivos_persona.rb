class ArchivosPersona < ActiveRecord::Base

  has_attached_file :archivo, 
    path: ":class/:id_partition/:filename",
    bucket: ENV["VIDEO_OUTPUT_BUCKET"],
    s3_permissions: :private

  validates_attachment_presence :archivo
  validate :my_validation
  validate :my_size_validation
  #validates_attachment_size :archivo, less_than: 1.megabyte
  do_not_validate_attachment_file_type :archivo

  def my_size_validation
    msg=""
    if self.tipo == 1
      if archivo.size > 1048576
        msg = "El archivo debe pesar máximo 1MB."
      end
    end
    if self.tipo == 2
      if archivo.size > 5242880
        msg = "El archivo debe pesar máximo 5MB."
      end
    end
    if self.tipo == 3
      if archivo.size > 5242880
        msg = "El archivo debe pesar máximo 5MB."
      end
    end
    if msg != ""
      errors.add(:archivo, msg)
    end
  end

  def my_validation
    types=[]
    msg=""
    if self.tipo == 1
      types = ["application/pdf","application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/msword"]
      msg = "El archivo debe tener formato .pdf, .doc o .docx"
    end
    if self.tipo == 2
      types = ["application/pdf","application/vnd.openxmlformats-officedocument.wordprocessingml.document","audio/mpeg","application/msword","audio/mp3","audio/mpeg3","audio/x-mpeg-3"]
      msg = "El archivo debe tener formato .pdf, .doc, .docx o .mp3"
    end
     if self.tipo == 3
      types = ["application/pdf","application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/msword"]
      msg = "El archivo debe tener formato .pdf, .doc, .docx "
    end
    if !types.include? archivo.content_type.chomp
      errors.add(:archivo, msg)
    end
  end
end
