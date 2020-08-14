class Answer < ApplicationRecord
  belongs_to :question

  has_rich_text :content
end
