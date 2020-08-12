class Chapter < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
