class AddVideoUrLtoSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :video_url, :string
  end
end
