class WebMailer < ApplicationMailer
  default from: "mattnwalsh@gmail.com", to: "mattnwalsh@gmail.com"

  def coaching
    mail(subject: "[lsatcracked.com] Coaching Request for #{params[:name]}")
  end
end
