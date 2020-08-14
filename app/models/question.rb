class Question < ApplicationRecord
  has_rich_text :content

  has_many :answers, dependent: :destroy
  belongs_to :section
end
