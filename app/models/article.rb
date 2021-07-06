class Article < ApplicationRecord
  include Quizable

  accepts_nested_attributes_for :questions

  has_rich_text :content
  validates :intro, uniqueness: true
end
