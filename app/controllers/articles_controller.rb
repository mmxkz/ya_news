class ArticlesController < ApplicationController
  def actual
    @article = Article.actual
  end

  def create
  end
end
