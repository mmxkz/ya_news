require "rails_helper"
require "pry"

describe Admin::ArticlesController do
  describe "GET new" do
    context "when there is no actual article" do
      it "assigns @articles" do
        get :new
        expect(assigns(:article)).to be_a_new(Article)
      end
    end

    context "when there is actual article" do

      let(:actual_article) { FactoryBot.build(:article) }

      before(:each) do
        allow(Article).to receive(:actual_from_author).and_return(actual_article)
      end

      it "assigns @articles" do
        get :new
        expect(assigns(:article)).to eq(actual_article)
      end
    end
  end

  describe "POST/PATCH update" do
    context "when pass correct attributes" do
      let(:new_attributes) do
        { title: 'new title', annotation: 'new content', published_to: Time.zone.tomorrow + 1.minute }
      end

      before(:each) do
        @article = FactoryBot.create(:article, published_to: Time.zone.tomorrow)
        post :update, params: { article: new_attributes }
      end

      it "should render new view with flash success" do
        expect(response).to render_template("new")
        expect(flash[:success]).to match "Successful"
      end

      it "should update article with new attributes" do
        @article.reload
        expect(@article.slice(new_attributes.keys).symbolize_keys).to eql new_attributes
      end
    end

    context "when pass incorrect attributes" do
      let(:new_attributes) do
        { title: nil, annotation: 'new content', published_to: Time.zone.tomorrow + 1.minute }
      end

      before(:each) do
        @article = FactoryBot.create(:article, published_to: Time.zone.tomorrow)
        post :update, params: { article: new_attributes }
      end

      it "should render new view with flash error" do
        expect(response).to render_template("new")
        expect(flash[:error]).to match "Failed"
      end
    end
  end
end
