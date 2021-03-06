Myapp::Application.routes.draw do
  get "/404" => "errors#not_found"
  get "/500" => "errors#internal_server_error"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: "omniauth_callbacks"}
  resources :courses, only: [:index, :show] do
    resources :lectures, only: [:index, :show] do
      resources :comments, module: :lectures
    end
    resources :enrols, only: [:create]
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  resources :users, only: [:show, :index]
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  match 'search' => 'search#index', via: [:get, :post], as: :search
  resources :recipes, only: [:index, :show] do
    resources :comments
  end
  resources :casts, only: [:index, :show] do
    resources :comments
  end
  get 'feed' => 'recipes#feed'
  get 'recipes?tag=:tag', to: 'recipes#index', as: :tag
  get 'terms' => 'home#terms'
  get 'privacy' => 'home#privacy'
  get "pricing" => "home#pricing"
  get "/about" => "home#about"
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
