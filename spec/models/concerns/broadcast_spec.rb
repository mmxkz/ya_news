require "rails_helper"

describe Broadcast do
  describe "#broadcast" do
    context "when create actual yandex article" do
      let(:article) { FactoryBot.build :article }

      before(:each) do
        article
        allow(NewsBroadcastJob).to receive(:perform_later)
      end

      it "should receive NewsBroadcastJob" do
        article.save
        expect(NewsBroadcastJob).to have_received(:perform_later)
      end
    end

    context "when create actual author article" do
      let(:article) { FactoryBot.build :article, published_to: Time.zone.now + 1.minute }

      before(:each) do
        article
        allow(NewsBroadcastJob).to receive_message_chain(:set, :perform_later)
      end

      it "should receive NewsBroadcastJob" do
        article.save
        expect(NewsBroadcastJob).to have_received(:set)
      end
    end
  end
end
