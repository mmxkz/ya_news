require "rails_helper"

describe NewsBroadcastJob do
  subject(:job) { described_class.perform_later(key) }

  let(:key) { 123 }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
      .with(key)
      .on_queue("broadcast_news")
  end
end
