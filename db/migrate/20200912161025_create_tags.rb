class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :slug
      t.boolean :premium, null: false, default: false

      t.timestamps
    end
    add_index :tags, :slug
  end
end
