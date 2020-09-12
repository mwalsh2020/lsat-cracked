class Question < ApplicationRecord
  has_rich_text :prompt
  has_rich_text :explanation

  has_many :answers, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  belongs_to :section

  def tag_slugs=(slugs)
    self.tags = slugs.map do |slug|
      Tag.find_or_create_by!(slug: slug)
    end
  end
end
