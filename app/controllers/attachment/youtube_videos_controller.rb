class Attachment::YoutubeVideosController < ApplicationController
  def show
    @youtube_video = Attachment::YoutubeVideo.new(id: params[:id])
    authorize @youtube_video

    render json: {
      sgid: @youtube_video.attachable_sgid,
      content: render_to_string(
        partial: "thumbnail",
        locals: { youtube_video: @youtube_video },
        formats: [:html]
      )
    }
  end
end
