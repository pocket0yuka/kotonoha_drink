# kotonoha_drink

# [言の葉 drink]

[![Image from Gyazo](https://i.gyazo.com/dfec56765fae1795fc3133b0e78ce8cc.png)](https://gyazo.com/dfec56765fae1795fc3133b0e78ce8cc)

## サービスURL
https://kotonoha-drink.com


## サービス概要

「言の葉 drink」は、花に「花言葉」があるように飲み物にドリンク言葉を生成するアプリです。
ユーザーはアプリを通じてその日の気分や特別な場面に合ったドリンクを見つけることができ、それぞれのドリンクには特別なメッセージが添えられます。

## 想定されるユーザー層

- 20~40 歳代男女
- お酒を飲む人
- その日の出来事や気分に合わせて飲み物を選びたいと考える人
- ギフト、記念日やお祝いごとなど意味ある飲み物を見つけたい人

## サービスコンセプト

何の飲み物を飲もうかと選択に迷ったある日、花言葉のように飲み物にもそれぞれの言葉があれば、選ぶ際に意味を持たせることができ、選択のきっかけや新たな楽しみ方が生まれると考えました。
「言の葉 drink」は各ドリンクに言葉を結びつけることによって、飲み物が持つ価値をユーザーにとってより深いものへと再定義します。これによってユーザーは自分の気持ちやその日の気分にマッチするドリンクを選ぶことができます。また、ギフトとして飲み物を選ぶ際に、そのドリンクが持つメッセージを通じて受け取る人への思いを伝えることができます。
市場には数多くの飲み物関連サービスが存在し、レシピ提案、お店の紹介、飲料の記録やレビューなど、味や品質に重きを置いています。対してこのサービスはユーザーの感情や気分を中心に据えます。
飲み物を選ぶプロセスに心理的な要素を融合させることで、個々の気持ちに合わせたドリンクの提案、
または、それに対応する言葉を添えることによって、飲み物を介した感情表現を手伝います。

## このサービスへの想い・作りたい理由

私はお酒が好きで様々な種類のお酒を飲む機会がありますが、中でもカクテルについては名前を見ただけではどのような飲み物か見当がつかず、似たようなものばかり選んでしまうことがありました。新しい味に挑戦したいという思いと楽しい、面白いという感情を誰かと共有できたらいいなと思っていました。
また、お酒を飲めない人にも楽しんで欲しいという思いから非アルコール飲料を含めた全ての飲み物を対象に言葉を生成するサービスを考案しました。


### 機能一覧

| ユーザー登録・ログイン |
| :---: |
| [![Image from Gyazo](https://i.gyazo.com/0e604d2559ee46a77ed3f0a7541a3103.gif)](https://gyazo.com/0e604d2559ee46a77ed3f0a7541a3103) |
- ユーザー登録機能
- ログイン/ログアウト機能
  - googleログイン機能
- open AI APIへの接続回数の制限機能(1ユーザーに対して1日3回まで)
  - 日付の変更でリセット、次回使用可能までの時間を表示(フラッシュメッセージ)

| ドリンク生成機能 |
| :---: |
| [![Image from Gyazo](https://i.gyazo.com/8e9ab3b580d5ee71051c9ccb314fe9f4.gif)](https://gyazo.com/8e9ab3b580d5ee71051c9ccb314fe9f4) |
- ドリンク言葉生成機能(ドリンク名からの生成、文章からドリンクの提案と生成)
  - テキスト生成、画像生成機能

| 生成結果保存機能 |
| :---: |
| | [![Image from Gyazo](https://i.gyazo.com/b396b5d56a6e51652481b2bd3658f890.gif)](https://gyazo.com/b396b5d56a6e51652481b2bd3658f890) | |
| [![Image from Gyazo](https://i.gyazo.com/308880cd6515216ea848f2071ec0988e.gif)](https://gyazo.com/308880cd6515216ea848f2071ec0988e) |
  - 生成結果保存機能
    - ドリンクの検索(ドリンク名、ドリンク言葉、ドリンク情報)、並び替え機能
  - シェア機能、xへのソーシャルシェア機能
- ユーザーによるドリンク言葉の作成・保存機能

| 投稿機能 |
| :---: |
| [![Image from Gyazo](https://i.gyazo.com/7a6065212487c6a81f1649676a34495c.gif)](https://gyazo.com/7a6065212487c6a81f1649676a34495c) |
[![Image from Gyazo](https://i.gyazo.com/2749edce6680f6d46aaae3cf39121366.gif)](https://gyazo.com/2749edce6680f6d46aaae3cf39121366)
- 本日飲んだ一杯についての投稿機能(画像、タグ、ドリンク言葉、投稿内容)
  - 公開・非公開機能
  - タグ検索機能（オートコンプリート機能）
  - いいね機能
  - ドリンク名のタグからの商品検索機能(楽天商品検索)
  - 画像アップロード機能、プレビュー機能

- プロフィール編集機能
  - 通知機能
- メニュー表(生成結果のデータを入れたドリンク表)

### 使用スタック
- フレームワーク
  - Rails 7.0.8
  - ruby 3.2.2
  - JavaScript
  - Node.js v20.11.0
- フロントエンド
  - TailwindCSS
  - DaisyUI
- バックエンド
  - Redis (APIリクエスト管理)
- データベース
  - PostgreSQL
- 認証
  - Devise(Googleアカウントログイン)
- CI/CD & デプロイ
  - fly.io
  - Docker
- バージョン管理
  - GitHub
- テスト
  - RSpec
  - Capybara
  - RuboCop
- API 
  - open AI API
  - 楽天商品検索API
  - Google OAuth

### 画面遷移図

https://www.figma.com/file/TzDlpu5ueA88VE0lWfjm1f/%E8%A8%80%E3%81%AE%E8%91%89drink?type=design&node-id=0%3A1&mode=design&t=cCWeppUp6ODTxtdM-1

### ER 図

[![Image from Gyazo](https://i.gyazo.com/094c4293ea5c2d7286e6960e0fb454ad.png)](https://gyazo.com/094c4293ea5c2d7286e6960e0fb454ad)