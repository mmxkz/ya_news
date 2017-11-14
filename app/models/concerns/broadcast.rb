module Broadcast
  extend ActiveSupport::Concern

  included do
    after_commit :broadcast, on: [:create, :update], if: -> { self.eql? Article.actual }

    def broadcast
      NewsBroadcastJob.perform_later
      NewsBroadcastJob.set(wait_until: published_to + 1.seconds).perform_later if published_to
    end
  end
end
