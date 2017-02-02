Rails.application.routes.draw do
  root 'welcome#index'
  resources :charges
  get 'downgrade' => 'charges#downgrade'
  post 'downgrade' => 'charges#downgrade_posts'
  devise_for :users
  resources :posts do
    resources :collaborators
  end
end
