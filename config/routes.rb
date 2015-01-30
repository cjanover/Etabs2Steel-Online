Rails.application.routes.draw do
  
  root 'main#index'

  resources :main
  resources :users
  resources :users do
    member do
      post :load
    end
  end
  
  
  resource :session, :only => [:new, :create, :destroy]
  get '/login' => "sessions#new", :as => "login"
  delete '/logout' => "sessions#destroy", :as => "logout"
  
  resource :software, :only => [:show]
  resource :documentation, :only => [:show]
  resource :etabs2_steel_manuals, :only => [:show]
  resource :etabs2_steel_online_manuals, :only => [:show]
  resource :etabs_vs_steel_pushover_papers, :only => [:show]
  resource :about, :only => [:show]
  
  
  resources :profiles
  resources :defaults
  resources :model_informations
  resources :analysis_options
  resources :convergence_options
  
  resources :fiber_options
  resources :nsefbr_fibers
  resources :nsefbc_fibers
  
  resources :vertical_constraint_options
  resources :vertical_constraints
  
  resources :load_options

  resources :response_time_history_options
  resources :extra_time_histories
  
  resources :material_models
  
  resources :foundation_node_options
  resources :foundation_nodes
  
  
  resources :models do
    resources :analyses do
      member do
        post :submit
      end
      resources :defaults do
        resources :model_informations
        resources :analysis_options
        resources :convergence_options
        resources :fiber_options do
          resources :nsefbr_fibers
          resources :nsefbc_fibers
        end
        resources :vertical_constraint_options do
          resources :vertical_constraints
        end
        resources :load_options
        resources :response_time_history_options do
          resources :extra_time_histories
        end
        resources :material_models
        resources :foundation_node_options do
          resources :foundation_nodes
        end
      end
    end
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
