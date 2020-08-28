class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter
  has_many :questions, dependent: :destroy
  has_many :quizzes, dependent: :destroy

  acts_as_list scope: :chapter
end
