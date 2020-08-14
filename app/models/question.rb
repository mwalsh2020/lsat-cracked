class Question < ApplicationRecord
  has_rich_text :content

  has_many :answers
  belongs_to :section
end
