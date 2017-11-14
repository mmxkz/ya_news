class Article < ApplicationRecord
  include Broadcast

  scope :from_yandex, -> { where published_to: nil }
  scope :with_actual_published_to, -> { where("published_to > ?", Time.zone.now) }

  validates :title, presence: true
  validates :annotation, presence: true
  validate :check_published_to, on: [:create, :update], if: -> { self.published_to.present? }

  def check_published_to
    if published_to < DateTime.now
      errors.add(:published_to, "can't be in the past")
    end
  end

  class << self
    def actual
      actual_from_author || actual_from_yandex
    end

    def actual_from_author
      with_actual_published_to.last
    end

    def actual_from_yandex
      from_yandex.last
    end
  end
end
