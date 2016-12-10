Rails.application.routes.draw do

  # TOP
  root 'welcome#index'

  # 記事
  resources :articles

  # コメント（画面内遷移なし）
  resources :comments

  # いいね
  resources :feelings

  # 図書
  resources :books, shallow: true do
    member do
      patch 'rent'
    end
    resources :comments
  end

  # スライド
  resources :slides
  get 'recommendSlides' => 'slides#recommend'

  # 貸出履歴
  get 'rent_history' => 'rent_history#index'

  # ユーザー管理
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

end
