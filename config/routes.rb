Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  
  # ユーザー側
  root 'user/homes#top'
  get "/about" => "user/homes#about"
  
  scope module: :public do
    resources :movies, only: [:index, :show] do
      resources :reviews, only: [:show, :new, :create, :edit, :update, :destroy]
    end
    resources :users, only: [:index,:show,:edit,:create,:destroy,:update] 
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
