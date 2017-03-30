Rails.application.routes.draw do
  get  'about'       => 'welcome#about'
  get  'contact'     => 'welcome#contact'
  get  'help'        => 'welcome#help'
  resources :charges
  get  'downgrade'   => 'charges#downgrade'
  post 'downgrade'   => 'charges#downgrade_posts'
  devise_for :users
  resources :posts do
    resources :collaborators
  end
  authenticated :user do
   root 'posts#index', as: :authenticated_root
  end
  root 'welcome#index'
end
