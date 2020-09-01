class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :orderable, polymorphic: true

  monetize :amount_cents

  enum state: { pending: 0, paid: 1 }
end
