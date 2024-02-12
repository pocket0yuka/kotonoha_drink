# frozen_string_literal: true

# いいねの通知に関するコントローラ
class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).find_each do |notification|
      notification.update(checked: true)
    end
  end
end
