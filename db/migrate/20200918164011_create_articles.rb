class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.boolean :published, default: false, null: false

      t.timestamps
    end
  end
end
