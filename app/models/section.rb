class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter
  has_many :questions

  def video?
    youtube_video_id.present?
  end
end
