class Section < ApplicationRecord
  include Quizable

  has_rich_text :content

  has_many :question

  belongs_to :chapter
  belongs_to :question

  acts_as_list scope: :chapter

  def previous
    higher_item || chapter.higher_item&.sections&.last
  end

  def next
    lower_item || chapter.lower_item&.sections&.first
  end
end
