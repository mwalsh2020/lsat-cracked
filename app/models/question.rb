class Question < ApplicationRecord
  has_rich_text :content

  belongs_to :section
end
