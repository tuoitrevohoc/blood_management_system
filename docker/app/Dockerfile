FROM ruby:2.3.6

RUN apt-get update && apt-get install -y build-essential curl cron logrotate gettext-base nano
RUN apt-get clean
RUN apt-get update -qq && apt-get install -y build-essential nodejs

RUN mkdir -p /app
WORKDIR /app

COPY ./Gemfile /Gemfile
COPY ./Gemfile.lock /Gemfile.lock

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

EXPOSE 3000
