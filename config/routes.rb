KABT::Application.routes.draw do
#  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  #match '/static_pages', to: 'omniauth_callbacks'

  #get '/static_pages', to: 'static_pages#index'
  root :to => 'static_pages#login'
  match '/static_pages', to: 'static_pages#index', via: 'get', as: :front_page
  match '/login_page', to: 'static_pages#login', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/login', to: 'users#login', via: 'post'

  resources :users
  match 'users/:id/change_password' => 'users#change_password', via: 'get', as: :change_password
  match 'users/:id/update_password' => 'users#update_password', via: 'put', as: :update_password
  #match 'users/:id/dashboard' => 'users#dashboard', via: 'get', as: :show_dashboard
  # TODO decide which view to render for dashboard
  #match 'users/:id/available' => 'videos#available', via: 'get'

  match 'users/:id/videos/:video_id/assign_translator' => 'videos#assign_translator', via: 'post'
  match 'users/:id/videos/:video_id/assign_typer' => 'videos#assign_typer', via: 'post'
  match 'users/:id/videos/:video_id/assign_qa' => 'videos#assign_qa', via: 'post'
  match 'users/:id/videos/:video_id/set_translate_complete' => 'videos#set_translate_complete', via: 'post'
  match 'users/:id/videos/:video_id/set_type_complete' => 'videos#set_type_complete', via: 'post'
  match 'users/:id/videos/:video_id/set_qa_complete' => 'videos#set_qa_complete', via: 'post'


  match 'users/:id/videos/translate' => 'videos#translate', via: 'get', as: :translate
  match 'users/:id/videos/available' => 'videos#available', via: 'get', as: :show_dashboard
  match 'users/:id/videos/digitize' => 'videos#digitize', via: 'get', as: :digitize
  match 'users/:id/videos/qa' => 'videos#qa', via: 'get', as: :qa
  match 'users/:id/videos/completed' => 'videos#completed', via: 'get', as: :completed
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_in', :to => 'users#login', :as => :new_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_session
  end

  #get '/auth/:provider/callback' => 'sessions#create'
  #get '/auth/failure' => 'users/sessions#failure'
  #match '/logout' => 'sessions#destroy'

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
