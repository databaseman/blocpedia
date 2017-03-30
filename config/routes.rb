Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'

  get  'about'       => 'welcome#about'
  get  'contact'     => 'welcome#contact'
  get  'help'        => 'welcome#help'
  resources :charges
  get  'downgrade'   => 'charges#downgrade'
  post 'downgrade'   => 'charges#downgrade_posts'
  devise_for :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  
  resources :posts do
    resources :collaborators
  end
  authenticated :user do
   root 'posts#index', as: :authenticated_root
  end
  root 'welcome#index'
end
