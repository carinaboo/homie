Homie::Application.routes.draw do
  
  root :to => 'home#index'

  post '/reviews', to: 'reviews#create', as: 'create_review'
  get "reviews/:id/edit", to: 'reviews#edit', as: 'edit_review'
  put "reviews/:id", to: 'reviews#update', as: 'update_review'
  get "reviews/:apt_id", to: 'reviews#find_by_apt', as: 'reviews_find_by_apt'
  delete 'reviews/:id', to: 'reviews#delete', as:'delete_review'

  get 'apartments/search', to: 'apartments#search'
  #get 'apartments/delete', to: 'apartment#delete', as: 'delete_apartment'
  resources :apartments
  # devise_for :users

  devise_for :users 
  # devise_for :users do
    # get '/users/sign_out', to: 'devise/sessions#destroy'
  # end
  resources :users, :only => [:show]

  # get "/", to: 'home#index', as: 'home_index'
  
  
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