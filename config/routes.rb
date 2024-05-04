Rails.application.routes.draw do

  # 管理者側
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    root "members#index"
    resources :members, only: [:show, :update]
    resources :reviews, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

  # ユーザー側
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }

  # ゲストログイン
  devise_scope :user do
    post "user/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  root "user/homes#top"
  get "/about" => "user/homes#about"

  scope module: :user do
    get  "users/check" => "users#check"
    patch  "users/withdraw" => "users#withdraw"
    resources :users, only: [:index, :show, :edit, :create, :destroy, :update] do
      get :favorites
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

    get "tags" => "tags#search"
    get "keywords" => "keywords#search"
  end

end
