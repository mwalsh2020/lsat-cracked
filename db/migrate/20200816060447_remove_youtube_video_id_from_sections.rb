class RemoveYoutubeVideoIdFromSections < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :youtube_video_id, :string
  end
end
