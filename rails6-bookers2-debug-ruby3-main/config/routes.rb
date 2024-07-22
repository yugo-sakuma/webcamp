Rails.application.routes.draw do
  devise_for :users
  
  root :to => "homes#top"
  get "home/about" => "homes#about"
  get 'search' => 'searches#search'
  get 'sort_books', to: 'books#sort_by_likes', defaults: { format: :js }

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
end
