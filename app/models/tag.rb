# frozen_string_literal: true

# タグのモデル
class Tag < ApplicationRecord
  has_many :posttags, dependent: :destroy
  has_many :posts, through: :posttags

  validates :name, presence: true

  # Ransackによる検索可能な属性を定義
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name]
  end
end
