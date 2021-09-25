class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :quizable, polymorphic: true

  has_many :quiz_questions, dependent: :destroy
  has_many :questions, through: :quiz_questions
  has_many :answers, through: :quiz_questions

  accepts_nested_attributes_for :quiz_questions, reject_if: :all_blank,
                                                 allow_destroy: true
  accepts_nested_attributes_for :questions, reject_if: :all_blank,
                                            allow_destroy: true
  accepts_nested_attributes_for :answers, reject_if: :all_blank,
                                          allow_destroy: true

  scope :complete, -> { where(complete: true) }
  scope :pending, -> { where.not(complete: true) }

  def session
    Quiz::Session.new(quiz: self)
  end
end
