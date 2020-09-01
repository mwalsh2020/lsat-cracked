class WebMailer < ApplicationMailer
  default from: "coaching@lsatcracked.com", to: "matt@lsatcracked.com"

  def coaching
    mail(subject: "[lsatcracked.com] Coaching Request for #{params[:name]}")
  end
end
