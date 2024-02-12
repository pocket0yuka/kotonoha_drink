# frozen_string_literal: true

# プロフィールのコントローラ
class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  before_action :set_user, only: %i[show edit update]

  def show
    @notifications = Notification.where(visited_id: @user.id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :favorite_drink)
  end
end
