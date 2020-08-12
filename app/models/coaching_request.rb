class CoachingRequest
  include ActiveModel::Model

  attr_accessor :name, :email, :target_law_school, :target_lsat_score, :message

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
