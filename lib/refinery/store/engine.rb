require 'redis'

module Refinery
  module Store
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Store

      engine_name :refinery_store

      after_inclusion do
        Refinery.include_once(::Refinery::User, Refinery::Store::UserAddon)

        # Global variable to access Redis driver
        $redis = Redis.new(:driver => :hiredis)
      end

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "store"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.store_admin_orders_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/store/order',
            :title => 'order_number'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Store)
      end
    end
  end
end
