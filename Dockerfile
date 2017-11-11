FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /ya_news
WORKDIR /ya_news
ADD Gemfile /ya_news/Gemfile
ADD Gemfile.lock /ya_news/Gemfile.lock
RUN bundle install
ADD . /ya_news
