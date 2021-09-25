class Chapter < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :sections, -> {
                        order(position: :asc)
                      }, dependent: :destroy, inverse_of: :chapter
  accepts_nested_attributes_for :sections, reject_if: :all_blank,
                                           allow_destroy: true

  acts_as_list
end
