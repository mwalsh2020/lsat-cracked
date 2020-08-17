class Answer < ApplicationRecord
  belongs_to :question

  has_rich_text :content

  def name
    content
  end
end
