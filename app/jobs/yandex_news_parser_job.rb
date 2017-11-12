require 'rss'
require 'open-uri'

class YandexNewsParserJob < ApplicationJob
  queue_as :yandex_news

  RSS_URL = "https://news.yandex.ru/index.rss".freeze

  def perform
    last_main_yandex_news
  end

  def last_main_yandex_news
    rss = RSS::Parser.parse(open(RSS_URL).read, false).items[0]
    { title: rss.title, published_at: rss.pubDate, annotation: rss.description }
  end
end
