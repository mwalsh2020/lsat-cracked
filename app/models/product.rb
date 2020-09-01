class Product < ApplicationRecord
  validates :sku, uniqueness: true
  validates :name, :sku, :price, :full_price, presence: true

  monetize :price_cents
  monetize :full_price_cents

  has_rich_text :description
end
