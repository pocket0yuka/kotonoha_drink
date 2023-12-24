# ベースイメージの指定
FROM ruby:3.2.2-slim

# 環境変数の設定
ENV TZ=Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LC_ALL C.UTF-8
ENV EDITOR=vim

# 必要なパッケージのインストール（git,vim,yarn,node.js,curlなどを追加）
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev vim curl git \
    && curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install --global yarn

# testfileディレクトリの作成
WORKDIR /kotonoha_drink

# GemfileとGemfile.lockのコピー
COPY Gemfile Gemfile.lock /kotonoha_drink/

# bundle installの実行
RUN bundle install

# ローカルの現在のディレクトリをコンテナ内にコピー
COPY . /kotonoha_drink/

# entrypoint.shの設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#コンテナがリッスンするPORTを指定
EXPOSE 3000

CMD ["./bin/dev"]