class Bookmark < ApplicationRecord
  belongs_to :user
  #フィルタリングロジックをモデルに移行、且つ再利用しやすくするためActiveSupport::Concernを採用
  include BookmarkFiltering

  mount_uploader :image, ImageUploader
end
