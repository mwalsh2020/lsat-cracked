class Section < ApplicationRecord
  include Quizable

  has_rich_text :content

  belongs_to :chapter

  acts_as_list scope: :chapter
end
