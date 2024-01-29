class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #(ログイン、パスワード編集)許可に必要なパラメータ
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
  end

  #ログインした後profileにリダイレクトする
  def after_sign_in_path_for(resource)
    drink_menus_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
