Rails.application.routes.draw do

# ユーザーログイン
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
# ゲストログイン
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
# 管理者ログイン
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}


  # ユーザー側ページ
  root 'user/homes#top'
  get "/about" => "user/homes#about"
  
  scope module: :user do
    resources :users, only: [:index, :show, :edit, :create, :destroy, :update] do
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
    end
    resources :movies, only: [:index, :show] do
      resources :reviews, only: [:new, :create, :show, :edit, :update, :destroy]
      resource :favorite, only: [:create, :destroy]
    end
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
