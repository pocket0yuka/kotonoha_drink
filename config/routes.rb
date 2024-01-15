Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  #Userがログインしている場合のアクセス
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    resource :profile, only: %i[show edit update]
  end

  root "homes#index"
  resource :drinkwords, only: %i[show]
end
