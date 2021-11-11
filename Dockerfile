FROM ruby:3.0.0

WORKDIR /usr/src/app

COPY . .

ENV RAILS_ENV production

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

RUN bundle install && \
    bin/rails assets:precompile

CMD ["bin/rails", "server"]