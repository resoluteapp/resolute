FROM ruby:3.0.3

ARG HONEYBADGER_FRONTEND_API_KEY

ENV RAILS_ENV production
ENV NODE_ENV production

WORKDIR /usr/src/app

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    corepack enable

COPY . .

RUN bundle install && \
    SECRET_KEY_BASE=1 bin/rails assets:precompile

CMD ["bin/rails", "server"]
