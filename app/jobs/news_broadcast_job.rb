class NewsBroadcastJob < ApplicationJob

  queue_as :broadcast_news

  def perform
    article = Article.actual
    ActionCable.server.broadcast "article", article: ArticlesController.render(partial: 'articles/article', locals: { article: article })
  end
end
