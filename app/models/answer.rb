class Answer < ApplicationRecord
  belongs_to :question

  has_rich_text :content
  has_many :quiz_questions, dependent: :destroy

  def name
    content
  end
end
