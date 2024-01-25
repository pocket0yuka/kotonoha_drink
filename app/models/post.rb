class Post < ApplicationRecord
  belongs_to :user
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags
  has_many :favorites, dependent: :destroy

  validates :body, presence: true
  validates :visibility, presence: true

  enum visibility: { 非公開: 0, 公開: 1 }

  #現在ログインしているユーザーによっていいねされてる？
  def favorited_by?(user)
    #いいねは存在してる？(いいねを既に押してるか、押していないか)
    favorites.exists?(user_id: user.id)
  end

  # Ransackによる検索可能な属性を定義
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "user_id", "visibility"]
  end
  # タグ名で検索可能にするためのメソッド
  def self.ransackable_associations(auth_object = nil)
    ["tags"]
  end
end
