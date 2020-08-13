class ChaptersController < ApplicationController
  def new
    @chapter = Chapter.new
    authorize @chapter
  end

  def create
    @chapter = Chapter.new(chapter_params)
    authorize @chapter
    if @chapter.save
      redirect_to chapters_path
    else
      render :new
    end
  end

  def index
    @chapters = policy_scope(Chapter)
  end

  def show
    @chapter = Chapter.find(params[:id])
    authorize @chapter
  end

  def edit
    @chapter = Chapter.find(params[:id])
    authorize @chapter
  end

  def update
    @chapter = Chapter.find(params[:id])
    authorize @chapter
    if @chapter.update(chapter_params)
      redirect_to chapter_path(@chapter.id)
    else
      render :edit
    end
  end

  def destroy
    @chapter = Chapter.find(params[:id])
    authorize @chapter

    @chapter.destroy
    redirect_to chapters_path
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title)
  end
end
