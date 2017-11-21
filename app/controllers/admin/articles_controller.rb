module Admin
  class ArticlesController < ApplicationController
    before_action :set_article

    def new; end

    def update
      if @article.update_attributes(article_params)
        flash.now[:success] = "Successful"
      else
        flash.now[:error] = "Failed"
      end
      render :new
    end

    private

    def set_article
      @article = Article.actual_from_author || Article.new
    end

    def article_params
      params.require(:article).permit(:title, :annotation, :published_to)
    end
  end
end
