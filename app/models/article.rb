class Article < ApplicationRecord
  has_rich_text :content
  has_many :quizable_questions, as: :quizable
end
