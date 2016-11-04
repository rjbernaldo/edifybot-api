FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt-get install -y libxml2-dev libxslt1-dev

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENV app /app
RUN mkdir $app
COPY . $app
WORKDIR $app

EXPOSE 3000
