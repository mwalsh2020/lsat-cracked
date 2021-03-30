class Section < ApplicationRecord
  include Quizable

  has_rich_text :content

  belongs_to :chapter

  acts_as_list scope: :chapter

  def previous
    higher_item || chapter.higher_item&.sections&.last
  end

  def next
    lower_item || chapter.lower_item&.sections&.first
  end
end
