Rails.application.routes.draw do

  # TOP
  root 'welcome#index'

  # 記事
  resources :articles
  get 'search' => 'articles#search'

  # コメント（画面内遷移なし）
  resources :comments

  # いいね
  resources :feelings

  # 図書
  resources :books, shallow: true do
    member do
      patch 'rent'
      patch 'bring_back'
    end
    resources :comments
  end

  # 貸出履歴
  get 'rent_history' => 'rent_history#index'

  # PUSH
  post 'push' => 'push#create'

  # Mail
  post 'mail' => 'mail#create'

  # ユーザー管理
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

end
