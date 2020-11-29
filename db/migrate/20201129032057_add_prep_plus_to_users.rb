class AddPrepPlusToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prep_plus, :boolean, null: false, default: false
  end
end
