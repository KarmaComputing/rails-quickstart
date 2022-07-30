FROM ruby:3.1.2

WORKDIR /usr/src/app

COPY ./app/Gemfile ./

RUN bundle install

COPY . .

ENTRYPOINT ./entrypoint.sh

EXPOSE 80
