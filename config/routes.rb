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
  get 'generatedresult', to: 'generatedresults#new'
  post 'generatedresults', to: 'generatedresults#create'
  get 'generatedresults', to: 'generatedresults#show'
  resource :profile, only: %i[show edit update]
  resources :bookmarks
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
  #メーラー用のurl
  Rails.application.routes.draw do
    mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  end
end
