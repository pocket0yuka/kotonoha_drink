require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  # アソシエーションのテストは省略（必要に応じて追加）

  describe 'バリデーション' do
    it '必要な情報が存在すれば有効' do
      bookmark = FactoryBot.build(:bookmark)
      expect(bookmark).to be_valid
    end
  end

  describe '画像ファイル' do
    it 'base64形式の画像データをデコードして画像をアップロードする' do
      user = FactoryBot.create(:user)
      bookmark = FactoryBot.create(:bookmark, user: user)
      base64_image_data = "ここにはテスト用のBase64エンコードされた画像データが入る"
      filename = "test_image"

      # テスト対象のメソッドを実行
      bookmark.download_image(base64_image_data, filename)

      # 画像がアップロードされたかを確認する（具体的な確認方法は、使用するシステムや要件により異なる）
      expect(bookmark.image.url).not_to be_nil
    end
  end

end
