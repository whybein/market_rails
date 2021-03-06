Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :items do
    member do
      get :toggle # 찜하기
      get :add # 장바구니 추가
    end
  end

  resources :orders
  resources :line_items
  resources :user_items
  resources :comments
  root "items#index"
end
