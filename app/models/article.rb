class Article < ApplicationRecord
  include Quizable

  has_rich_text :content
  validates :intro, uniqueness: true
end
