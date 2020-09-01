class AddFreeToChapters < ActiveRecord::Migration[6.0]
  def change
    add_column :chapters, :free, :boolean, null: false, default: false
  end
end
