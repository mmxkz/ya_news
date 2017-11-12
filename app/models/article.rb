class Article < ApplicationRecord
  scope :from_yandex, -> { where published_to: nil }
  scope :from_author, -> { where.not(published_to: nil) }

  scope :last_from_yandex, -> { from_yandex.last }
  scope :last_from_author, -> { from_author.last }

  class << self
    def actual
      Article.from_author.where("published_to > ?", Time.now).last ||
      Article.from_yandex.last
    end
  end
end
