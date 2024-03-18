require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '通知の作成' do
    let(:visitor) { FactoryBot.create(:user) }
    let(:visited) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: visited) }

    it '新しい通知が作成される' do
      notification = FactoryBot.create(:notification, visitor: visitor, visited: visited, post: post, action: 'favorite')
      expect(notification).to be_valid
    end
  end

  describe 'スコープ' do
    let!(:old_notification) { FactoryBot.create(:notification, created_at: 1.day.ago) }
    let!(:new_notification) { FactoryBot.create(:notification, created_at: 1.hour.ago) }

    it '通知が新しい順に並ぶ' do
      expect(Notification.first).to eq new_notification
    end
  end
end
