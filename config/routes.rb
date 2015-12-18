Rails.application.routes.draw do

  get 'myproducts/index'

  get 'myproducts/new'

  get 'myproducts/show'

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  # mount Spree::Core::Engine, :at => '/'
   mount Spree::Core::Engine, :at => '/'
          # get 'sessions/login'

  # get 'orders/show'

  # get 'cust_cards/show'

  # get 'vendors/show'

  # get 'admins/show'

  # get 'admins/new'

  # get 'users/show'

  # get 'users/new'


  get 'home', to: 'myproducts#index'

  resources :sessions  
  get 'mylogin', to: 'sessions#login'
  get 'mylogout', to: 'sessions#destroy'
  #get 'vendorlogin', to: 'sessions#vendorCreate', as: 'vendorlogin_path'
  #, :url => vendorlogin_path, method: :post

  resources :myproducts
  resources :users
  resources :admins
  
  resources :vendors
  get 'mydeals', to: 'vendors#show'

  resources :cust_cards
  resources :payables
  resources :orders

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
