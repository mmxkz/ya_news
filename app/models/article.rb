class Article < ApplicationRecord
  scope :from_yandex, -> { where published_to: nil }
  scope :from_author, -> { where.not(published_to: nil) }

  after_create_commit :broadcast, if: -> { self == Article.actual }

  def broadcast
    NewsBroadcastJob.perform_later(self)
    NewsBroadcastJob.set(wait_until: self.published_to + 1.seconds).perform_later if published_to
  end

  class << self
    def actual
      Article.from_author.where("published_to > ?", Time.now).last ||
      Article.from_yandex.last
    end

    def last_from_yandex
      from_yandex.last
    end
  end
end
