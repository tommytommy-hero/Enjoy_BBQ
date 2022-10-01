Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'recipes/show'
    get 'recipes/index'
    get 'recipes/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'recipes/new'
    get 'recipes/index'
    get 'recipes/show'
    get 'recipes/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/index'
    get 'users/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :users,skip:[:passwords], controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admins,skip:[:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
