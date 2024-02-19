Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # ログイン後にリダイレクトするパスを設定
  devise_scope :user do
    # ログアウトパス
    get '/users/sign_out' => 'devise/sessions#destroy'
    resources :users, only: [:show]
  end

  root 'homes#index'
  # ログイン後、drinksにリダイレクト(application_controller参照)
  get 'generatedresult', to: 'generatedresults#new'
  post 'generatedresults', to: 'generatedresults#create'
  get 'generatedresults', to: 'generatedresults#show'
  resources :drinks, only: %i[index show]
  resource :profile, only: %i[show edit update]
  resources :bookmarks
  resources :socialsharings, only: %i[show index create]
  resources :posts do
    resource :favorites, only: %i[create destroy]
    collection do
      get 'search', to: 'posts#index', as: :search
      post 'search', to: 'posts#index', as: :search_post
    end
  end
  resources :tags do
    get :search, on: :collection
  end
  # メーラー用のurl
  Rails.application.routes.draw do
    mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  end
  resources :notifications, only: %i[index]
  get 'contact', to: 'statics#contact'
  get 'terms_of_service', to: 'statics#terms_of_service'
  get 'privacy_policy', to: 'statics#privacy_policy'
end
