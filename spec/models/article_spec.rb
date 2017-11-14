require "rails_helper"

describe Article do
  let(:author_article) { FactoryBot.create :article, published_to: Time.zone.now + 1.minute }
  let(:yandex_article) { FactoryBot.create :article }

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
    before(:each) do
      author_article
      yandex_article
    end

    describe ".from_yandex" do
      it "should return only news from yandex" do
        expect(Article.from_yandex.count).to eq 1
        expect(Article.from_yandex.last.id).to eq yandex_article.id
      end
    end

    describe ".with_actual_published_to" do
      let!(:future_author_article) { FactoryBot.create :article, published_to: Time.now + 2.minute }

      before(:each) do
        travel_to Time.now + 70.seconds
      end

      it "should return only news from author" do
        expect(Article.with_actual_published_to.count).to eq 1
        expect(Article.with_actual_published_to.last.id).to eq future_author_article.id
      end
    end
  end

  describe "#actual" do
    context "when there are no articles" do
      it "should return nil" do
        expect(Article.actual).to be_nil
      end
    end

    context "when there are articles" do
      before(:each) do
        yandex_article
        author_article
      end

      context "when actual article is author" do
        it "should return author article", focus: true do
          expect(Article.actual).to eq author_article
        end
      end

      context "when actual article is yandex" do
        before(:each) do
          travel_to Time.now + 3.minutes
        end

        it "should return yandex article" do
          expect(Article.actual).to eq yandex_article
        end
      end
    end
  end

  describe "#actual_from_author" do
    context "when there are no articles" do
      it "should return nil" do
        expect(Article.actual_from_author).to be_nil
      end
    end

    context "when there are actual authors articles" do
      before(:each) do
        author_article
      end

      context "when there are actual authors article" do
        it "should return author article" do
          expect(Article.actual_from_author).to eq author_article
        end
      end
    end
  end

  describe "#actual_from_yandex" do
    context "when there are no articles" do
      it "should return nil" do
        expect(Article.actual_from_yandex).to be_nil
      end
    end

    context "when there are actual yandex articles" do
      before(:each) do
        yandex_article
      end

      context "when there are actual yandex article" do
        it "should return yandex article" do
          expect(Article.actual_from_yandex).to eq yandex_article
        end
      end
    end
  end
end
