class Admin::SectionsController < ApplicationController
  def new
    @chapter = Chapter.find(params[:chapter_id])
    @section = Section.new
    authorize @section
  end

  def create
    @chapter = Chapter.find(params[:chapter_id])

    @section = Section.new(section_params)
    @section.chapter = @chapter

    authorize @section
    if @section.save
      redirect_to [:admin, @chapter]
    else
      render :new
    end
  end

  def edit
    @section = Section.find(params[:id])
    authorize @section
  end

  def update
    @section = Section.find(params[:id])
    authorize @section
    if @section.update(section_params)
      redirect_to [:admin, @section.chapter]
    else
      render :edit
    end
  end

  private

  def section_params
    params.require(:section).permit(:title, :content, :youtube_video_id)
  end
end
