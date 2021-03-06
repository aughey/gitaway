Gitaway::Application.routes.draw do
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
  # root :to => "welcome#index"

  resources :passwords,
    :controller => 'clearance/passwords',
    :only       => [:new, :create]

  resource  :session,
    :controller => 'clearance/sessions',
    :only       => [:new, :create, :destroy]

  resources :users, :controller => 'clearance/users', :only => [:new, :create] do
    resource :password,
      :controller => 'clearance/passwords',
      :only       => [:create, :edit, :update]

    resource :confirmation,
      :controller => 'clearance/confirmations',
      :only       => [:new, :create]
  end

  match 'sign_up'  => 'clearance/users#new', :as => 'sign_up'
  match 'sign_in'  => 'clearance/sessions#new', :as => 'sign_in'
  match 'sign_out' => 'clearance/sessions#destroy', :via => :delete, :as => 'sign_out'

  resources :u, :controller => 'u'

  resources :ssh_keys

  resources :repositories

  match 'repositories/:id/tree/:treeid', :controller => 'repositories', :action => 'tree'
  match 'repositories/:id/blob/:blobid', :controller => 'repositories', :action => 'blob'
  match 'repositories/:id/commits/:branch', :controller => 'repositories', :action => 'commits'
  match 'repositories/:id/commit/:commit', :controller => 'repositories', :action => 'commit'
  match 'repositories/:id/fork', :controller => 'repositories', :action => 'fork'
  match 'repositories/:id', :controller => 'repositories', :action => 'show'
  match 'repositories/:id/:branch', :controller => 'repositories', :action => 'show'
  match 'repositories/:id/:branch/*path', :controller => 'repositories', :action => 'show'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
