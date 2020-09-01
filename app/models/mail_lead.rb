class MailLead
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def submit!
    User.invite!(email: email)
  end
end
