class Video < ActiveRecord::Base
  Paperclip.interpolates :fixed_file_name do |attachment, style|
    attachment.instance.fixed_file_name
  end

  belongs_to :profesor
  belongs_to :observador
  belongs_to :video_estado
  belongs_to :evaluacion

  # Flag para agregar el video sin archivo
  attr_accessor :skip_file

  has_attached_file :attach, 
    path: ":class/:attachment/:id_partition/:style/:fixed_file_name.:extension",
    s3_permissions: :private

  validates_attachment_presence :attach, unless: :skip_file
  validates_attachment_size :attach, less_than: 350.megabyte, unless: :skip_file
  do_not_validate_attachment_file_type :attach
  ##validates_attachment_content_type :attach, 
  ##  :content_type => ["video/mp4","video/flv","video/x-flv","application/octet-stream"], 
  ##  :message => "Solo se soportan videos en formato MP4/flv"
  
  def clean_test
    video=Video.find(self.id)
    video.attach_file_name = nil
    video.attach_content_type = nil
    video.attach_file_size = nil
    video.attach_updated_at = nil
    video.video_estado_id = nil
    video.transcoder_job_id = nil
    video.conversion_status = nil
    video.revisado = false
    video.identidad_verificada = nil
    video.intentos = 0
    video.save(validate:false)
    ##self.save(validate:false)
    Evaluacion.where(video_id: self.id).map{|x|x.delete}
    Reporte.where(video_id: self.id).map{|x|x.delete}
  end
  
  def fixed_file_name
    return "video"
  end

  def video_path
    input_key = URI(self.attach.url).path
    input_key = input_key[1..input_key.length]
    input_key
  end

  def preview_path
    s3 = AWS::S3.new(access_key_id: ENV["AWS_ACCESS_KEY_ID"], secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"])
    obj = s3.buckets[ENV["VIDEO_PREVIEW_BUCKET"]].objects[video_path]
    obj.url_for(:read, expires: 10).to_s
  end

  def self.initiate_video_conversion video, delete
    key = URI(video.attach.url).path
    length = key.length
    key = key[1..length]
    if delete
      Funciones::Amazon.delete_object(ENV["VIDEO_OUTPUT_BUCKET"], key)
      #delete_object ENV["VIDEO_OUTPUT_BUCKET"], input_key, delete_key, length
    end
    transcoder_client = AWS::ElasticTranscoder::Client.new(region: ENV["VIDEO_REGION"])
    options = set_options(ENV["VIDEO_PIPELINE_ID"], key)
    job = transcoder_client.create_job(options)
    job_id = job[:job][:id]
    video.transcoder_job_id = job_id
    video.save
  end

  def self.delete_object bucket, input_key, delete_key, length
    delete_key = input_key[0..length] + delete_key
    s3 = AWS::S3.new(access_key_id: ENV["AWS_ACCESS_KEY_ID"], secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"])
    obj = s3.buckets[bucket].objects[delete_key]
    obj.delete
  end

  # Actualiza el estado de la conversion de los videos
  def self.update_progreso_conversion_videos
    Video.uncached do
      sqs_client = AWS::SQS::Client.new(region: ENV["VIDEO_REGION"])
      sqs_messages = get_sqs_messages sqs_client, ENV["AWS_QUEUE_URL"], 5, 10
      videos_array = Video.where(conversion_status: ["PROGRESSING", nil])
      while !sqs_messages.blank? && !videos_array.blank? do
        sqs_messages.each do |msg|
          job_id = JSON.parse(JSON.parse(msg[:body])['Message'])['jobId']
          state = JSON.parse(JSON.parse(msg[:body])['Message'])['state']
          vid = videos_array.where(transcoder_job_id: job_id).first
          if !vid.blank? && vid.transcoder_job_id == job_id
            if state == "WARNING"
              state = "COMPLETED"
            end
            vid.conversion_status = state
            vid.save
          end
          delete_msg sqs_client, ENV["AWS_QUEUE_URL"], msg
          videos_array = Video.where(conversion_status: ["PROGRESSING", nil])
          if videos_array.blank?
            break
          end
        end
        if Video.all.count == Video.where(conversion_status: ["WARNING", "COMPLETE", "ERROR"]).count
          break
        end
        sqs_messages = get_sqs_messages sqs_client, ENV["AWS_QUEUE_URL"], 5, 10
      end
    end
  end

  # Retorna un batch de mensajes de amazon
  # Parametros:
  # => sqs_client: cliente de SQS de amazon
  # => queue_url:  url de la cola de amazon
  # => wait_time:  tiempo maximo de espera en segundos para
  #                recibir el mensaje
  # => max_msg:    numero maximo de mensajes
  def self.get_sqs_messages sqs_client, queue_url, wait_time, max_msg
    sqs_messages = sqs_client.receive_message(
        queue_url: queue_url,
        wait_time_seconds: wait_time,
        max_number_of_messages: max_msg
        ).data[:messages]
    sqs_messages
  end

  # Elimina un mensaje de la cola de amazon
  def self.delete_msg sqs_client, queue_url, msg
    sqs_client.delete_message(
      :queue_url => queue_url,
      :receipt_handle => msg[:receipt_handle]
      )
  end

  def self.set_options pipeline_id, input_key
    options = {
      pipeline_id: pipeline_id,
      input: {
        key: input_key,
        frame_rate: "auto",
        resolution: "auto",
        aspect_ratio: "auto",
        interlaced: "auto",
        container: "auto"
      },
      outputs: [
        key: input_key,
        thumbnail_pattern: "",
        rotate: "auto",
        preset_id: "1351620000001-000001",
        composition: [
          {
            time_span: {
              start_time: "00:00:00.000",
              duration: "00:00:30.000"
            }
          }
        ]
      ]
    }
    options
  end

  def get_extension
    ext = File.extname(self.video_path)
    ext.downcase!
    ext
  end

  def cloudfront_path
    string = "rtmp://" + ENV["RTMP_DISTRO"] + "/cfx/st/flv:" + self.video_path
    string
  end
end
