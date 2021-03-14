class Manage::TagsController < Manage::ApplicationController
  def index
    @tags = policy_scope([:admin, Tag])
  end

  def new
    @tag = Tag.new
    authorize [:admin, @tag]
  end

  def create
    @tag = Tag.new(tag_params)
    authorize [:admin, @tag]

    if @tag.save
      redirect_to [:admin, :tags]
    else
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    authorize [:admin, @tag]
  end

  def update
    @tag = Tag.find(params[:id])
    authorize [:admin, @tag]

    if @tag.update(tag_params)
      redirect_to [:admin, :tags]
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    authorize [:admin, @tag]

    @tag.destroy

    redirect_to [:admin, :tags]
  end

  private

  def tag_params
    params.require(:tag).permit(:slug)
  end
end
