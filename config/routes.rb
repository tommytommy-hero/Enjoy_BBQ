Rails.application.routes.draw do

  devise_for :users,skip:[:passwords], controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admins,skip:[:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }
  scope module: :public do
    resources :recipes do
      resource :favorites, only:[:create, :destroy]

      resources :comments, only:[:create, :destroy]

      collection do
        get 'search'
      end

      collection do
        get 'confirm'
        post 'confirm'
      end
    end

    resources :users, only:[:index, :show, :edit, :update] do
      resource :relationships, only:[:create, :destroy]
        get 'relationships/followings', as: 'followings'
        get 'relationships/followers', as: 'followers'
    end

    root to: 'homes#top'
    get 'about' => 'homes#about'
  end

  namespace :admin do
    resources :users, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :edit, :create, :update, :destroy]
    resources :recipes, only:[:index, :edit, :create, :update, :destroy]
    root to: 'homes#top'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
