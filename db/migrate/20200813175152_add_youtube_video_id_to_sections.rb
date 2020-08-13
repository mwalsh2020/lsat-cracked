class AddYoutubeVideoIdToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :youtube_video_id, :string
  end
end
