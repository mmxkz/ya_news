class ArticlesController < ApplicationController
  around_action :set_time_zone, only: :create
  def actual
    @article = Article.actual
  end

  def new
    @article = Article.last_from_yandex || Article.new
  end

  def create
    @article = Article.new article_params

    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_time_zone(&block)
    Time.use_zone(Time.zone.name, &block)
  end

  def article_params
    params.require(:article).permit(:title, :annotation, :published_to)
  end
end
