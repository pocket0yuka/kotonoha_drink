require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    let(:user){ FactoryBot.build(:user) } # buildを使用してDBへの保存前のインスタンスを生成

    it "name、email、passwordが存在すれば登録できること" do
    expect(user).to be_valid  # user.valid? が true になればパスする
    end

    it "emailが重複している場合は登録できないこと" do
      user.save # 最初のユーザーを保存
      another_user = FactoryBot.build(:user, email: user.email) # 同じemailを持つユーザーを生成
      expect(another_user).not_to be_valid
    end
    
  end
end
