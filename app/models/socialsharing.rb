# frozen_string_literal: true

# (ソーシャルシェア兼)みんなが作ったドリンク言葉一覧のモデル
class Socialsharing < ApplicationRecord
  # ImageUploader を使用して、カラムにファイルをアップロードできるようになる。
  mount_uploader :image, ImageUploader

  # apiによる生成画像から画像(base64形式)をpngに変換
  def download_image(base64, filename)
    # base64をデコード
    image_data = Base64.decode64(base64)
    # 一時ファイルを作成、base64をこのファイルに書き込む
    file = Tempfile.new([filename, '.png'])
    file.binmode # バイナリモードでの書き込みを指定
    file << image_data # base64データを書き込む
    file.rewind # ファイルポインタを先頭に戻す
    # CarrierWaveを使用してアップロード
    self.image = file
    file.close
    file.unlink # 一時的なファイルのため読み込んだ後削除する
  end
end
