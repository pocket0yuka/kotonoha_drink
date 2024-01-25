class Post < ApplicationRecord
  belongs_to :user
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags

  validates :body, presence: true
  validates :visibility, presence: true

  enum visibility: { 非公開: 0, 公開: 1 }

    # Ransackによる検索可能な属性を定義
    def self.ransackable_attributes(auth_object = nil)
      ["body", "created_at", "id", "user_id", "visibility"]
    end

    # タグ名で検索可能にするためのメソッド
    def self.ransackable_associations(auth_object = nil)
      ["tags"]
    end
end
