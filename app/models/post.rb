class Post < ApplicationRecord
  belongs_to :user
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

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

  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end
