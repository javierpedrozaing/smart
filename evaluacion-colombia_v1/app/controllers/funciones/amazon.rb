class Funciones::Amazon
  def initialize
  end

  # Given a request from SNS and a topic ARN
  # it either subscribe to the topic or process the message
  # sent by given topic
  def self.update_video_state request, arn = ENV["VIDEO_NOTIFICATION_TOPIC_ARN"]

    amz_message_type = request.headers['x-amz-sns-message-type']
    amz_sns_topic = request.headers['x-amz-sns-topic-arn']

    return unless !amz_sns_topic.nil? && amz_sns_topic.to_s.downcase == arn
    
    if amz_message_type.to_s == 'SubscriptionConfirmation'
      send_subscription_confirmation JSON.parse(request.body.read)
    else 
      msg = JSON.parse(JSON.parse(request.body.read)['Message'])
      job_id = msg['jobId']
      state = msg['state']
      video = Video.where(transcoder_job_id: job_id).first
      if !video.blank? && video.transcoder_job_id == job_id
        if video.conversion_status != "COMPLETED"
          video.conversion_status = state
          video.save
        end
      end
    end
  end

  # Confirms subscription by doing a get petition to the
  # subscribe URL given on the request message
  def self.send_subscription_confirmation(request_body)
    subscribe_url = request_body['SubscribeURL']
    return nil unless !subscribe_url.to_s.empty? && !subscribe_url.nil?
    subscribe_confirm = HTTParty.get subscribe_url
  end

  # deletes an object from a bucket in amazon given 
  # its key and the bucket name
  def self.delete_object bucket, key
    s3 = AWS::S3.new(access_key_id: ENV["AWS_ACCESS_KEY_ID"], secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"])
    object = s3.buckets[bucket].objects[key]
    object.delete
  end

  def self.get_options pipeline_id, key
    options = {
        pipeline_id: pipeline_id,
        input: {
          key: key,
          frame_rate: "auto",
          resolution: "auto",
          aspect_ratio: "auto",
          interlaced: "auto",
          container: "auto"
        },
        outputs: [
          key: key,
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

end