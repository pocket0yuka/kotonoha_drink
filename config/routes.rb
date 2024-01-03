Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  #Userがログインしている場合のアクセス
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get 'mypage', to: 'users#show', as: :user_mypage
  end

  root "homes#index"
end
