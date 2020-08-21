class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :section

  has_many :quiz_questions, dependent: :destroy
  has_many :questions, through: :quiz_questions

  accepts_nested_attributes_for :quiz_questions

  validates :questions, presence: true

  scope :complete, -> { where(complete: true) }
  scope :pending, -> { where.not(complete: true) }

  def session
    Quiz::Session.new(quiz: self)
  end
end
