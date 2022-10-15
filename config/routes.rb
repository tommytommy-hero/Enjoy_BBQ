Rails.application.routes.draw do

  devise_for :users,skip:[:passwords], controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admins,skip:[:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }
  scope module: :public do
    resources :users, only:[:index, :show, :edit, :update] do
      resource :relationships, only:[:create, :destroy]
      get 'relationships/followings', as: 'followings'
      get 'relationships/followers', as: 'followers'

      member do
        get :favorites
      end
    end
    resources :recipes do
      resource :favorites, only:[:create, :destroy]

      resources :comments, only:[:create, :destroy] do
        resource :comment_favorites, only:[:create, :destroy]
      end

      collection do
        get 'search'
      end

      collection do
        get 'confirm'
        post 'confirm'
      end
    end
    resources :contacts, only:[:create, :index]

    root to: 'homes#top'
  end

  namespace :admin do
    resources :users, only:[:index, :show, :update] do
      collection do
        get 'search'
      end
    end
    resources :genres, only:[:index, :edit, :create, :update, :destroy]
    resources :recipes, only:[:index,:show, :update, :destroy] do
      resources :comments, only:[:destroy]
    end
    resources :contacts, only:[:show, :index, :update]
    root to: 'homes#top'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
