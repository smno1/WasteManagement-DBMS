Rails.application.routes.draw do

  resources :current_months

  resources :baseline_data

  get 'data_search/company_search', as: 'company_search'
  get 'data_search/site_search', as: 'site_search'

  resources :saving_against_baselines

  resources :current_invoices

  resources :contacts

  resources :baseline_invoices

  devise_for :users, controllers: { registrations: "users/registrations" }
  
  resources :services do
    resources :baseline_invoices, shallow:true
    resources :current_invoices, shallow:true
    resources :saving_against_baselines, shallow:true
    resources :baseline_data, shallow:true
  end

  resources :commentaries

  resources :sites do
    resources :services, shallow:true
    resources :commentaries, shallow:true
    resources :contacts, shallow:true
  end

  get 'welcome/portal'

  resources :companies do
    resources :sites, shallow:true
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#portal'

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
