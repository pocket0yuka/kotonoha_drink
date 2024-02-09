# frozen_string_literal: true

# 通知モデル
class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post, optional: true

  belongs_to :visitor, class_name: 'User', inverse_of: :active_notifications
  belongs_to :visited, class_name: 'User', inverse_of: :passive_notifications
end
