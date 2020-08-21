class Question < ApplicationRecord
  has_rich_text :content
  has_rich_text :explanation
  has_many :answers, dependent: :destroy

  belongs_to :section
end
