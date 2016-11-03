Rails.application.routes.draw do

  # ようこそ
  root 'welcome#index'

  # 記事一覧
  resources :articles
  resources :comments

  # 図書一覧
  resources :books, shallow: true do
    member do
      patch 'rent'
    end
    resources :comments
  end

  # スライド一覧
  resources :slides
  get 'recommendSlides' => 'slides#recommend'

  # 貸出履歴
  get 'rent_history' => 'rent_history#index'

  # ユーザー管理
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

  # ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end
