Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :items do
    member do
      get :toggle # 찜하기
    end
  end

  resources :orders
  root "items#index"
end
