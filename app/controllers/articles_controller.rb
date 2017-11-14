class ArticlesController < ApplicationController
  def index
    @article = Article.actual
  end
end
