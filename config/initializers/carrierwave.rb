# CarrierWaveの設定呼び出し
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# 保存先の分岐
CarrierWave.configure do |config|
  if Rails.env.production? ||  Rails.env.development?  # 本番環境の場合はS3へアップロード
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'kotonoha-drink' # バケット名
    config.fog_public = false
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/kotonoha-drink'
    config.fog_credentials = {
      provider: 'AWS',
      #環境変数で管理
      aws_access_key_id: ENV['S3_ACCESS_KEY_ID'], # アクセスキー
      aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'], # シークレットアクセスキー
      region: 'ap-northeast-1', # 東京リージョン
    }
  else # 本番環境以外の場合はアプリケーション内にアップロード
    config.storage :file
    config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end
end
