# frozen_string_literal: true

# 投稿に対するいいね機能のモデル
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
