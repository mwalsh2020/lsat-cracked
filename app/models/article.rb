class Article < ApplicationRecord
  has_one :quiz_template, as: :quizable
  has_rich_text :content
  has_many :quizable_questions, as: :quizable
end
