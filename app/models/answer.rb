class Answer < ApplicationRecord
  belongs_to :question

  has_rich_text :content
  has_many :quiz_questions, dependent: :destroy

  scope :correct, -> { where(correct: true) }
  scope :wrong, -> { where(correct: false) }
  scope :recently_answered, -> { where("quiz_questions.updated_at > ?", 3.days.ago )}

  def name
    content
  end
end
