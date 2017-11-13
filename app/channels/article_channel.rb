class ArticleChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'article'
  end
end
