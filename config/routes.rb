Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  resources :books, only: [:new, :create, :index, :show, :destroy]
  resources :homes, only: [:top, :about]
  resources :users, only: [:show, :edit, :update, :index]
end