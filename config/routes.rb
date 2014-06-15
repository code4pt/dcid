Dcid::Application.routes.draw do
  resources :users
  resources :sessions,  only: [:new, :create, :destroy]
  resources :proposals do
    member do
      post :vote_for, :vote_against
    end
  end

  root 'static_pages#home'

  get   '/tags/:tag', to: 'proposals#tagged',   :as => 'tag'
  match '/tags',      to: 'proposals#tags',     via: 'get'

  match '/home',    to: 'static_pages#home',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/how',     to: 'static_pages#how',     via: 'get'
  match '/terms',   to: 'static_pages#terms',   via: 'get'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404', via: 'get'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
