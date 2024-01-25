class Post < ApplicationRecord
  belongs_to :user
  has_many :posttags, dependent: :destroy
  has_many :tags, through: :posttags

  validates :body, presence: true
  validates :visibility, presence: true

  enum visibility: { 非公開: 0, 公開: 1 }

end
