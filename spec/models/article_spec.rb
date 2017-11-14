require "rails_helper"

describe Article do
  context "validates" do
    let(:article) { Article.new }
    let(:past_article) { Article.new published_to: Time.now - 1.minutes }
    let(:future_article) { Article.new published_to: Time.now + 1.minutes }

    it "title should be required" do
      article.valid?
      expect(article.errors[:title].size).to eq 1
    end

    it "annotation should be required" do
      article.valid?
      expect(article.errors[:annotation].size).to eq 1
    end

    it "published_to should be future" do
      past_article.valid?
      expect(past_article.errors[:published_to].size).to eq 1
    end

    it "published_to not should be past" do
      future_article.valid?
      expect(past_article.errors[:published_to].size).to eq 0
    end
  end

  describe "scopes" do
    let(:author_article) { FactoryBot.create :article, published_to: Time.now + 1.minute }
    let(:yandex_article) { FactoryBot.create :article }

    before(:each) do
      author_article
      yandex_article
    end

    describe "from_yandex" do
      it "should return only news from yandex" do
        expect(Article.from_yandex.count).to eq 1
        expect(Article.from_yandex.last.id).to eq yandex_article.id
      end

      it "should return only news from author" do
        expect(Article.from_author.count).to eq 1
        expect(Article.from_author.last.id).to eq author_article.id
      end
    end
  end
end
