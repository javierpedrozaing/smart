class ApplicationMailer < ActionMailer::Base
  default from: 'no-responder@icfes.gov.co'
  #layout 'mailer'
  def bienvenido_email(user)
    layout 'mailer'    
  end

end
