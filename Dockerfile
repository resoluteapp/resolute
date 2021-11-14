FROM ruby:3.0.0

ARG RAILS_MASTER_KEY=${RAILS_MASTER_KEY}
ENV RAILS_ENV production

WORKDIR /usr/src/app

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

RUN bundle install && \
    yarn install && yarn cache clean

COPY . .

RUN bin/rails assets:precompile

CMD ["bin/rails", "server"]
