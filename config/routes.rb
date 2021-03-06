Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    get '/logout' => 'sessions#destroy'

    get '/signup' => 'users#new'
    post '/users' => 'users#create'

    # for authentication // instgram
    # start sessions
    # get '/auth/:provider/callback', :to => 'sessions#create_with_instagram'
    get '/auth/:provider/callback', to: 'sessions#create_with_instagram'
    # fails sessions
    get '/auth/failure', :to => 'sessions#failure'
    #  get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    # get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'

    resources :users, only: [:index, :show, :update, :edit, :destroy] do
        resources :posts, only: [:index, :show, :new, :create, :update, :edit, :destroy]
        resources :braintree, only: [:new]
    end

      resources :users do
      member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
    
    post 'braintree/checkout'
    
    get "/allusers" => "users#all"
    # post "/welcome/send_text" => 'users#send_text'

    root 'welcome#index'


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
