FROM ruby:3.2.2-alpine3.18

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev" \
    RUBY_PACKAGES="ruby-json yaml"

# Update and install base packages and nokogiri gem that requires a
# native compilation
RUN apk update && \
    apk upgrade && \
    apk add --no-cache --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES && \
    mkdir -p /usr/src/myapp

# Copy the app into the working directory. This assumes your Gemfile
# is in the root directory and includes your version of Rails that you
# want to run.
WORKDIR /usr/src/myapp
COPY Gemfile /usr/src/myapp
COPY Gemfile.lock /usr/src/myapp

RUN gem install bundler
RUN bundle install

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
