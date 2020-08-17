class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter
  has_many :questions
  has_many :quiz_sessions

  def video?
    youtube_video_id.present?
  end

  def quiz?
    questions.any?
  end
end
