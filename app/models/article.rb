class Article < ApplicationRecord
  has_one :quiz_template, as: :quizable
  has_rich_text :content
end
