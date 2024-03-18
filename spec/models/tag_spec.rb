require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'バリデーション' do
    it 'nameが存在すれば有効であること' do
      tag = FactoryBot.build(:tag)
      expect(tag).to be_valid
    end

    it 'nameが存在しなければ無効であること' do
      tag = FactoryBot.build(:tag, name: nil)
      expect(tag).not_to be_valid
    end
  end

  describe 'ransack' do
    it 'ransackable_attributesが特定の属性の配列を返すこと' do
      expect(Tag.ransackable_attributes).to eq(%w[created_at id name])
    end
  end
end
