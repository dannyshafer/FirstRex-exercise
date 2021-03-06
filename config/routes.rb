Rails.application.routes.draw do
  resources :base_users
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get '/get_all_users' => 'base_users#get_all_users'
  get '/get_user_info' => 'base_users#get_user_info'
  get '/get_all_notes' => 'base_users#get_all_notes'
  get '/get_user_notes' => 'base_users#get_user_notes'
  get '/post_scores' => 'base_users#post_engagement_score_to_base'
  get '/companies' => 'companies#index'
  get '/companies_users' => 'companies#companies_users'
  get '/sales_directors_users' => 'sales_directors#sales_directors_users'
  get '/companies/(:id)' => 'companies#show'
  get '/sales_directors' => 'sales_directors#index'
  get '/sales_directors/(:id)' => 'sales_directors#show'
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
