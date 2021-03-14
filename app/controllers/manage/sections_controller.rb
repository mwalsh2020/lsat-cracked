class Manage::SectionsController < Manage::ApplicationController
  def new
    @chapter = Chapter.find(params[:chapter_id])
    @section = Section.new(chapter: @chapter)
    authorize @section
  end

  def create
    @chapter = Chapter.find(params[:chapter_id])

    @section = Section.new(section_params)
    @section.chapter = @chapter

    authorize @section
    if @section.save
      redirect_to [:admin, :chapters]
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
      redirect_to [:admin, :chapters]
    else
      render :edit
    end
  end

  def destroy
    @section = Section.find(params[:id])
    authorize @section
    @section.destroy

    redirect_to [:admin, :chapters]
  end

  private

  def section_params
    params.require(:section).permit(:title, :content, :position)
  end
end
