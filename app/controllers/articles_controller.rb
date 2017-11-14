class ArticlesController < ApplicationController
  def actual
    @article = Article.actual
  end

  def new
    @article = Article.last_from_yandex || Article.new
  end

  def create
    @article = Article.new article_params

    if @article.save
      redirect_to admin_path
    else
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :annotation, :published_to)
  end
end
