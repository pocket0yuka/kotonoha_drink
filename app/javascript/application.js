// Rails UJSのインポート
import Rails from "@rails/ujs";
Rails.start();

// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// storyフォームの文字残数の表示インポート
import "./story_form/character_count"

import { Application } from "@hotwired/stimulus"
import { Autocomplete } from 'stimulus-autocomplete'

const application = Application.start()
application.register('autocomplete', Autocomplete)

// 画像プレビューに関するjs
import "./image/preview"