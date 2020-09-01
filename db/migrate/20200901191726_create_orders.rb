class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :state, null: false, default: 0
      t.monetize :amount
      t.references :user, foreign_key: true
      
      t.string :checkout_session_id

      t.string :orderable_sku
      t.references :orderable, polymorphic: true
      
      t.timestamps
    end
  end
end
