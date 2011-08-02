Wallstickers::Application.routes.draw do
  root :to => 'pages#home'

  controller :user_sessions do
    get 'logout',         :to => :destroy,  :as => :logout
    post 'user_sessions', :to => :create
  end

  controller :shopping_cart do
    get  'cart',             :to => :shopping_cart, :as => 'shopping_cart'
    post '/cart/checkout',   :to => :checkout, :as => 'shopping_cart_checkout'
  end

  scope :path => '/order', :controller => :order_processing do
    get  ':id' => :show,   :as => 'show_order_progress'
    post ':id' => :update, :as => 'update_order_progress'
  end

  WALLSTICKER_PERMALINK_REGEXP = /[[:alnum:]]+\/[a-zA-Z0-9_+%-]+/
  controller :wallstickers do
    get  ':artist',              :to => :gallery,     :as => 'artist_gallery'
    get  ':artist/new',          :to => :new,         :as => 'new_wallsticker'
    post ':artist/new',          :to => :create,      :as => 'create_wallsticker'
    get  ':artist_title',        :to => :show,        :as => 'show_wallsticker',
         :constraints => { :artist_title => WALLSTICKER_PERMALINK_REGEXP }
    post ':artist_title/order',  :to => :add_to_cart, :as => 'add_wallsticker_to_cart',
         :constraints => { :artist_title => WALLSTICKER_PERMALINK_REGEXP }
    get  ':artist_title/order',  :to => redirect { |p| "/#{p[:artist_title]}" },
         :constraints => { :artist_title => WALLSTICKER_PERMALINK_REGEXP }
  end

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
