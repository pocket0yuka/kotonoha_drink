# ベースイメージの指定
FROM ruby:3.2.2-slim

# 本番環境用の環境変数を設定
#ENV RAILS_ENV="production"

# 環境変数の設定
ARG DB_USERNAME
ARG DB_PASSWORD
ARG DB_HOST
ARG DB_PORT
ARG OPENAI_ACCESS_TOKEN

ENV DB_USERNAME=$DB_USERNAME
ENV DB_PASSWORD=$DB_PASSWORD
ENV DB_HOST=$DB_HOST
ENV DB_PORT=$DB_PORT
ENV OPENAI_ACCESS_TOKEN=$OPENAI_ACCESS_TOKEN

ENV TZ=Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LC_ALL C.UTF-8
ENV EDITOR=vim

# 必要なパッケージのインストール（git,vim,yarn,node.js,curlなどを追加）
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev vim curl git \
    && curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install --global yarn \
    && npm install -g esbuild

RUN apt-get update -y && apt-get install -y imagemagick

# testfileディレクトリの作成
WORKDIR /kotonoha_drink

# GemfileとGemfile.lockのコピー
COPY Gemfile Gemfile.lock /kotonoha_drink/

# bundle installの実行
RUN bundle install

COPY package.json yarn.lock /kotonoha_drink/

RUN yarn install

RUN yarn add daisyui

RUN yarn add @hotwired/turbo-rails @hotwired/stimulus


# ローカルの現在のディレクトリをコンテナ内にコピー
COPY . /kotonoha_drink/

RUN yarn build

RUN yarn build:css

RUN bin/rails assets:precompile

# entrypoint.shの設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#コンテナがリッスンするPORTを指定
EXPOSE 3000

#コンテナ作成時にサーバーを立てる(本番環境用)
CMD ["rails", "server", "-b", "0.0.0.0"]

#CMD ["./bin/dev"]