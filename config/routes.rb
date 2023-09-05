Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users

  get 'home/about' => 'homes#about', as: 'about'

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]
end