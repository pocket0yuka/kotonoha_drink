// Rails UJSのインポート
import Rails from "@rails/ujs";
Rails.start();

// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// storyフォームの文字残数の表示インポート
import "./story_form/character_count"

// オートコンプリート
import { Application } from "@hotwired/stimulus"
import { Autocomplete } from 'stimulus-autocomplete'

const application = Application.start()
application.register('autocomplete', Autocomplete)

// 画像プレビューに関するjs
import "./image/preview"

//ローディング画面
import "./modal/loading"

//ドリンク注文時入力が空の状態でapiに接続しない調整
import "./api/generated_new"