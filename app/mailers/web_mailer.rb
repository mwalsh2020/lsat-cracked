class WebMailer < ApplicationMailer
  default from: "andrade@hey.com", to: "mattnwalsh@gmail.com"

  def coaching
    mail(subject: "New Coaching Request for #{params[:name]}")
  end
end
