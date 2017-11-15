require "rails_helper"

describe YandexNewsParserJob do
  subject(:job) { described_class.perform_later(key) }

  let(:key) { 123 }

  it 'queues the job' do
    ActiveJob::Base.queue_adapter = :test

    expect { job }.to have_enqueued_job(described_class)
      .with(key)
      .on_queue("yandex_news")
  end
end
