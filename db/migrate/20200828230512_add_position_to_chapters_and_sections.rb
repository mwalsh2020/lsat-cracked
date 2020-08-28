class AddPositionToChaptersAndSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :position, :integer
    add_column :chapters, :position, :integer
  end
end
