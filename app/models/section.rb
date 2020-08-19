class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter
  has_many :questions, dependent: :destroy
  has_many :quizzes, dependent: :destroy

  def quiz?
    questions.any?
  end
end
