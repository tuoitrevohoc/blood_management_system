FROM ruby:2.4.2-onbuild

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install -y nodejs

CMD ["bin/rails", "server"]
