class Answer < ApplicationRecord
  belongs_to :question

  has_rich_text :content
  has_many :quiz_questions, dependent: :destroy

  scope :correct, -> { where(correct: true) }
  scope :wrong, -> { where(correct: false) }

  def name
    content
  end
end
