class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter
  has_many :questions
end
