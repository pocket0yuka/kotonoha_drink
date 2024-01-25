class Tag < ApplicationRecord
  has_many :posttags, dependent: :destroy
  has_many :posts, through: :posttags

  validates :name, presence: true

    # Ransackによる検索可能な属性を定義
    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "name"]
    end

end
