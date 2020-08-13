class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter

  def video?
    youtube_video_id.present?
  end
end
