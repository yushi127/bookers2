Rails.application.routes.draw do
  root 'books#welcome'
  devise_for :users
  get 'books/welcome' => 'books#welcome', as: :welcome
  get 'home/about' => 'books#about', as: :about
  resources :users, only: [:index,:show, :edit, :update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
