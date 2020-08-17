class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter
  has_many :questions
  has_many :quiz_sessions

  def quiz?
    questions.any?
  end
end
