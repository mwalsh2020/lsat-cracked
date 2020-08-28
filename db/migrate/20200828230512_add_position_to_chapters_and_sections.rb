class AddPositionToChaptersAndSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :position, :integer
    add_column :chapters, :position, :integer

    Chapter.order(:updated_at).each.with_index(1) do |chapter, index|
      chapter.update_column(:position, index)

      chapter.sections.each.with_index(1) do |section, section_index|
        section.update_column(:position, section_index)
      end
    end
  end
end
