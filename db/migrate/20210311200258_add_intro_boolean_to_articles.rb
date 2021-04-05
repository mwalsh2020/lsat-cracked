class AddIntroBooleanToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :intro, :boolean, :default => false
  end
end
