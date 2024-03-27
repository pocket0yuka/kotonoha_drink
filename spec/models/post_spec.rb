require 'rails_helper'

RSpec.describe Post, type: :model do
  # バリデーションのテスト
  describe 'バリデーション' do
    it 'bodyとvisibilityが存在すれば有効であること' do
      post = FactoryBot.build(:post)
      expect(post).to be_valid
    end

    it 'bodyが存在しなければ無効であること' do
      post = FactoryBot.build(:post, body: nil)
      expect(post).not_to be_valid
    end

    it 'visibilityが存在しなければ無効であること' do
      post = FactoryBot.build(:post, visibility: nil)
      expect(post).not_to be_valid
    end
  end

  describe 'いいね機能' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }

    context 'ユーザーが投稿をいいねしている場合' do
      before do
        FactoryBot.create(:favorite, post: post, user: user)
      end

      it 'trueを返すこと' do
        expect(post.favorited_by?(user)).to be true
      end
    end

    context 'ユーザーが投稿をいいねしていない場合' do
      let(:other_user) { FactoryBot.create(:user) }

      it 'falseを返すこと' do
        expect(post.favorited_by?(other_user)).to be false
      end
    end
  end

  describe '通知機能' do
    let(:post_owner) { FactoryBot.create(:user) }
    let(:current_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: post_owner) }

    context 'いいねが初めての場合' do
      it '通知が作成されること' do
        expect {
          post.create_notification_favorite!(current_user)
        }.to change(Notification, :count).by(1)
      end
    end

    context '既にいいねがされている場合' do
      before do
        FactoryBot.create(:favorite, post: post, user: current_user)
        post.create_notification_favorite!(current_user)
      end

      it '通知が重複して作成されないこと' do
        expect {
          post.create_notification_favorite!(current_user)
        }.not_to change(Notification, :count)
      end
    end
  end
end
