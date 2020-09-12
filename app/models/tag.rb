class Tag < ApplicationRecord
  validate :slug, uniqueness: true, presence: true
end
