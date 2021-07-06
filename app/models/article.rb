class Article < ApplicationRecord
  include Quizable

  belongs_to :question
  accepts_nested_attributes_for :questions

  has_rich_text :content
  validates :intro, uniqueness: true
end
