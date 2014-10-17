Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :store do
    resources :orders, :only => [:index, :show]
  end

  # Admin routes
  namespace :store, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :orders, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
