class RenamePackagesToProducts < ActiveRecord::Migration[6.0]
  def change
    rename_table :packages, :products
  end
end
