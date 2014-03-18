LancarAbadi::Application.routes.draw do
  resources :filter do
    collection do
      get :country
      get :province
      get :city
      get :unit_of_measure
      get :category
      get :customer_group
      get :supplier
      get :customer
      get :product
      get :product_home
      get :purchase
      get :sale
    end
  end

  resources :sales do
    member do
      get :edit_footer
      get :print
    end
    
    collection do
      get :show_customer
      post :search_customer
      get :pick_customer
    end

    resources :sale_details do
      collection do
        get :show_product
        post :search_product
        get :pick_product
      end
    end
  end

  resources :purchases do
    member do
      get :edit_footer
      get :print_barcode
    end
    
    collection do
      get :show_supplier
      post :search_supplier
      get :pick_supplier
    end

    resources :purchase_details do
      collection do
        get :show_product
        post :search_product
        get :pick_product
      end
    end
  end

  resources :customers do
    collection do
      get :import
      post :import_submit
      get :import_phone
      post :import_phone_submit
    end
    
    resources :customer_phones
  end

  resources :suppliers do
    collection do
      get :import
      post :import_submit
      get :import_phone
      post :import_phone_submit
    end
    
    resources :supplier_phones
    resources :supplier_categories
  end

  resources :products do
    collection do
      get :import
      post :import_submit
      get :generate_barcode
      post :generate_barcode_submit
    end
    
    resources :product_purchases
  end

  resources :customer_groups
  resources :unit_of_measures
  resources :categories
  resources :cities
  resources :provinces
  resources :countries

  get "home/index"
  get "*module/home/provinces_by_country" => "home#provinces_by_country"
  get "*module/home/cities_by_province" => "home#cities_by_province"

  root to: "home#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
