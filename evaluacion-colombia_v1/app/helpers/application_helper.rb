module ApplicationHelper
  def permit_videos
    Rails.application.config.permit_videos
  end
end
