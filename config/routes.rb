Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :store do
    get 'store', to: 'store#index', as: :store
    resources :orders, :only => [:index, :show]
    resources :products, :only => [:index, :show]
    resources :retailers, :only => [:index, :show]
  end

  # Admin routes
  namespace :store, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :orders, :except => :show do
        collection do
          post :update_positions
        end
      end
      resources :order_items, :except => :show do
        collection do
          post :update_positions
        end
      end
      resources :retailers, :except => :show do
        collection do
          post :update_positions
        end
      end
      resources :products, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
