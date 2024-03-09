# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model cure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# 環境変数を管理し、.envファイルからアプリケーションに読み込むためのGem
gem 'dotenv-rails'

# ユーザー認証のための柔軟な認証ソリューションを提供するGem
gem 'devise', '~> 4.9'

# Deviseの多言語対応を提供するGem
gem 'devise-i18n'

# Devise用の多言語化されたビューを提供するGem
gem 'devise-i18n-views'

# Railsアプリケーションの多言語対応をサポートするGem
gem 'rails-i18n'

# ソーシャルログインなど、外部プロバイダを使った認証機能を提供するGem
gem 'omniauth'

# OmniauthでのCross-Site Request Forgery対策を提供するGem
gem 'omniauth-rails_csrf_protection'

# Googleアカウントによる認証をOmniauthを介して行うためのGem
gem 'omniauth-google-oauth2'

# ファイルアップロードを管理するためのGem
gem 'carrierwave'

# S3ストレージサービスと連携
gem 'fog-aws'

# 画像の処理（リサイズ、変換など）を行うためのMiniMagickをサポートするGem
gem 'mini_magick'

# openAIと通信するgem
gem 'ruby-openai'

# 検索機能
gem 'ransack'

# ページネーション
gem 'kaminari'

# キャッシュ管理
gem 'redis'

# ogp設定
gem 'meta-tags'

# 楽天api商品検索用
gem 'rakuten_web_service'

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # robocop コード整形
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # メール閲覧
  gem 'letter_opener_web'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
