Rails.application.routes.draw do

  get 'user_management/index', :as =>'user_management'

  get 'user_management/edit'

  get 'user_management/send_email'
  
  delete 'user_management/destroy'
  
  get 'user_management/update'

  get 'printable/site_month_invoice',:as=>'site_month_invoice'
  get 'printable/update_sites'
  get 'printable/printable_pdf', :as=>'printable_pdf'
  get '/update_sites', :controller=>'application',:action=>'update_sites'

  get 'welcome/portal'
  post 'welcome/update_pie_chart'
  post 'welcome/update_line_chart'
  resources :site_month_savings

  resources :current_months

  resources :baseline_data

  get 'data_search/company_search', as: 'company_search'
  get 'data_search/site_search', as: 'site_search'

  resources :saving_against_baselines
 #   match 'saving_against_baselines/update_site_select/:id',:controller=>'application',:action=>'update_site_select'
 #   match 'saving_against_baselines/update_service_select/:id',:controller=>'application',:action=>'update_service_select'

  resources :current_invoices

  resources :contacts

  resources :baseline_invoices

  devise_for :users, controllers: { registrations: "users/registrations" }
  
  resources :services do
    resources :baseline_invoices, shallow:true
    resources :current_invoices, shallow:true
    resources :saving_against_baselines, shallow:true
    resources :baseline_data, shallow:true
    resources :current_months, shallow:true
  end

  resources :commentaries

  resources :sites do
    resources :services, shallow:true
    resources :commentaries, shallow:true
    resources :contacts, shallow:true
    resources :site_month_savings, shallow:true
  end


  resources :companies do
    resources :sites, shallow:true
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  devise_scope :user do
    root to: 'users/sessions#new'
  end
  authenticated :user do
    root to: "welcome#portal", :as=>'portal'
  end
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
