Rails.application.routes.draw do
  resources :charges
  get 'downgrade' => 'charges#downgrade'
  post 'downgrade' => 'charges#downgrade_posts'
  resources :posts
  devise_for :users
  root 'welcome#index'
end
