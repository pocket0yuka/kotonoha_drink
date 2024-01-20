Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  #ログイン後にリダイレクトするパスを設定
  devise_scope :user do
    # ログアウトパス
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root "homes#index"
  # ログイン後、drink_menusにリダイレクト(application_controller参照)
  get '/drink_menus', to: 'drink_menus#index'
  get '/generatedresults', to: 'generatedresults#show'
  resource :profile, only: %i[show edit update]
  resources :bookmarks, only: %i[index create destroy show]
end
