module Admin
  class ArticlesController < ApplicationController
    before_action :set_article

    def new; end

    def update
      if @article.update_attributes(article_params)
        flash[:success] = "Successful"
        redirect_to admin_path
      else
        render :new
      end
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
