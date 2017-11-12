require 'rss'
require 'open-uri'

class YandexNewsParserJob < ApplicationJob
  RSS_URL = "https://news.yandex.ru/index.rss".freeze
  queue_as :yandex_news

  def perform
    last_from_yandex = last_main_yandex_news
    unless Article.last_from_yandex&.published_at&.utc == last_from_yandex[:published_at]&.to_time.utc
      Article.create(last_from_yandex)
    end
  end

  def last_main_yandex_news
    rss = RSS::Parser.parse(open(RSS_URL).read, false).items[0]
    { title: rss.title, published_at: rss.pubDate&.to_datetime, annotation: rss.description } if rss
  end
end
