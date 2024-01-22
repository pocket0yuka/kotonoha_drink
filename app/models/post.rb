class Post < ApplicationRecord
  belongs_to :user
  has_many :posttags, dependent: :destroy

  enum visibility: { private: 0, public: 1 }
end
