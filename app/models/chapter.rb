class Chapter < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :sections, -> { order(position: :asc) }, dependent: :destroy, inverse_of: :chapter

  acts_as_list
end
