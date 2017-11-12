FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs tmux

RUN mkdir /ya_news

WORKDIR /ya_news

CMD tmux new -ds sidekiq "sleep 60 && bundle exec sidekiq" && \
    tmux new -ds crono "sleep 60 && bundle exec crono" && \
    bundle exec rails server -b 0.0.0.0

ADD Gemfile /ya_news/Gemfile
ADD Gemfile.lock /ya_news/Gemfile.lock
RUN bundle install

ADD . /ya_news

