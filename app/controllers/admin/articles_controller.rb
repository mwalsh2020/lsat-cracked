class Admin::ArticlesController < Admin::ApplicationController
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = policy_scope([:admin, Article])
  end

  def new
    @article = Article.new
    authorize [:admin, @article]
  end

  def create
    @article = Article.new(article_params)
    authorize [:admin, @article]

    if @article.save
      redirect_to [:admin, :articles]
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to [:admin, :articles]
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to [:admin, :articles]
  end

  private

  def set_article
    @article = Article.find(params[:id])
    authorize [:admin, @article]
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
