FROM ruby:2.6.5
ENV BUNDLER_VERSION=2.1.4

RUN gem install bundler -v 2.1.4

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install
COPY . ./
EXPOSE 9292

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "9292"]
