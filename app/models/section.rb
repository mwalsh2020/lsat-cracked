class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter

  has_one :quiz_template, as: :quizable, dependent: :destroy
  has_many :questions, through: :quiz_template

  has_many :quizzes, as: :quizable, dependent: :destroy

  acts_as_list scope: :chapter
end
