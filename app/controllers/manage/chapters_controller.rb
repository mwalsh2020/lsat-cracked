class Manage::ChaptersController < Manage::ApplicationController
  def new
    @chapters = policy_scope(Chapter)
    @chapter = Chapter.new
    authorize @chapter
  end

  def create
    @chapter = Chapter.new(chapter_params)
    authorize @chapter
    if @chapter.save
      redirect_to [:admin, :chapters]
    else
      render :new
    end
  end

  def index
    @chapters = policy_scope(Chapter)
  end

  def edit
    @chapters = policy_scope(Chapter)
    @chapter = Chapter.find(params[:id])
    authorize @chapter
  end

  def update
    @chapter = Chapter.find(params[:id])
    authorize @chapter
    if @chapter.update(chapter_params)
      redirect_to [:admin, :chapters]
    else
      render :edit
    end
  end

  def destroy
    @chapter = Chapter.find(params[:id])
    authorize @chapter

    @chapter.destroy
    redirect_to admin_chapters_path
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title, :position, :free)
  end
end
