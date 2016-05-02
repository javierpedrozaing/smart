class Portafolio < ActiveRecord::Base
  #validates_attachment_presence :attach
  has_attached_file :archivo, 
    path: ":class/:attachment/:id_partition/:style/:basename.:extension",
    bucket: "portafolio-colombia"

  #validates_attachment_presence :attach, unless: :skip_file
  #validates_attachment_size :attach, less_than: 200.megabyte, unless: :skip_file
  do_not_validate_attachment_file_type :archivo
  #validates_attachment_content_type :attach, 
  # :content_type => /^video\/(mp4|x-flv)/, 
  #:message => "Solo se soportan videos en formato MP4/flv"
end
