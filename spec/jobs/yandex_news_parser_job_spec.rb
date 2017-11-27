require "rails_helper"

describe YandexNewsParserJob do
  let(:key) { 123 }
  subject(:job) { described_class.perform_later(key) }
  subject(:job_now) { described_class.perform_now }

  describe "queues" do
    it 'queues the job' do
      expect { job }.to have_enqueued_job(described_class)
        .with(key)
        .on_queue("yandex_news")
    end
  end

  describe "#perform" do
    before(:each) do
      stub_const("YandexNewsParserJob::RSS_URL", 'spec/files/yandex_news.rss')
    end

    context "when new parsed news from yandex not yet saved" do
      it "should add new job to queue" do
        expect do
          job_now
        end.to change(Article, :count).by(1)
      end
    end

    context "when new parsed news from yandex yet saved" do
      before(:each) do
        job_now
      end

      it "should not add new job to queue", focus: true do
        expect do
          job_now
        end.to change(Article, :count).by(0)
      end
    end
  end
end
