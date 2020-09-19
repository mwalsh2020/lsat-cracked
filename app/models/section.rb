class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter

  has_many :quizzes, as: :quizable, dependent: :destroy
  has_many :quizable_questions, as: :quizable, dependent: :destroy
  has_many :questions, through: :quizable_questions

  acts_as_list scope: :chapter
end
