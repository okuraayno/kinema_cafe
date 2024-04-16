Rails.application.routes.draw do

# 管理者側
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    root 'homes#top'
    resources :members, only: [:index, :show]
    resources :reviews, only: [:index, :show]
  end

# ユーザー側
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

# ゲストログイン
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root 'user/homes#top'
  get "/about" => "user/homes#about"

  scope module: :user do
    resources :users, only: [:index, :show, :edit, :create, :destroy, :update] do
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
    end
    resources :movies, only: [:index, :show] do
      resources :reviews, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :comments, only: [:create, :destroy]
      end
      resource :favorite, only: [:create, :destroy]
    end

    get "search" => "searches#search"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
