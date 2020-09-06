Rails.application.routes.draw do

  root 'projects#index'

  localized do
    devise_for :users
    resources :projects, only: [:index, :show, :new, :create, :edit], param: :slug do
      resources :cover, only: [:create, :delete]
    end
    resources :categories, only: [:index, :show], param: :slug
    resources :users, only: [:show]
    resources :admin, only: [:index]
    namespace :admin do
      resources :projects
    end
  end
end
