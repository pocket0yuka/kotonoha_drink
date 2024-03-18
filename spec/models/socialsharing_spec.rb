require 'rails_helper'

RSpec.describe Socialsharing, type: :model do

  describe '画像ファイル' do
    let(:socialsharing) { create(:socialsharing) }
    let(:base64) { 'ここにbase64エンコードされた画像データを挿入' }
    let(:filename) { 'test_image' }

    it 'base64形式をデコードし、画像ファイルとして保存' do
      expect {
        socialsharing.download_image(base64, filename)
      }.to change { socialsharing.image? }.from(false).to(true)
    end
  end

  describe 'バリデーション' do
    it 'socialsharingのバリデーションチェック' do
      socialsharing = build(:socialsharing)
      expect(socialsharing).to be_valid
    end
  end
end
