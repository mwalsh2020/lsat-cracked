class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.monetize :price, currency: { present: false }
      t.monetize :full_price, currency: { present: false }

      t.timestamps
    end
  end
end
