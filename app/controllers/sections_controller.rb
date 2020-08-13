class SectionsController < ApplicationController
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
      redirect_to @chapter
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
    if @section.update(section_params)
      redirect_to @section.chapter
    else
      render :edit
    end
  end

  def show
    @section = Section.find(params[:id])
    authorize @section
  end

  private

  def section_params
    params.require(:section).permit(:title, :content)
  end
end
