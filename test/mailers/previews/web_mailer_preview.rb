# Preview all emails at http://localhost:3000/rails/mailers/web_mailer
class WebMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/web_mailer/coaching
  def coaching
    WebMailer.coaching
  end

end
