class Manage::ArticlesController < Manage::ApplicationController
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = policy_scope([:manage, Article])
  end

  def new
    @article = Article.new
    authorize [:manage, @article]
  end

  def create
    @article = Article.new(article_params)
    authorize [:manage, @article]

    if @article.save
      redirect_to [:manage, :articles]
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to [:manage, :articles]
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to [:manage, :articles]
  end

  private

  def set_article
    @article = Article.find(params[:id])
    authorize [:manage, @article]
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
