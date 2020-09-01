class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :sku
      t.monetize :price, currency: { present: false }

      t.timestamps
    end
  end
end
