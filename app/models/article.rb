class Article < ApplicationRecord
  scope :from_yandex, -> { where published_to: nil }
  scope :from_author, -> { where.not(published_to: nil) }

  validates :title, presence: true
  validates :annotation, presence: true
  validate :check_published_to, on: :create, if: -> { self.published_to.present? }

  after_create_commit :broadcast, if: -> { self == Article.actual }

  def check_published_to
    if published_to < DateTime.now
      errors.add(:published_to, "can't be in the past")
    end
  end

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

    def last_from_yandex
      from_author.last
    end
  end
end
