FROM ruby:3.1.2-bullseye

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libpq-dev

WORKDIR /quero_api
COPY Gemfile /quero_api/Gemfile
COPY Gemfile.lock /quero_api/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]