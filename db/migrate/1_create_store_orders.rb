class CreateStoreOrders < ActiveRecord::Migration

  def up
    create_table :refinery_orders do |t|
      t.string :order_number
      t.string :reference
      t.decimal :quantity
      t.string :unit
      t.integer :user_id
      t.string :status
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-store"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/store/orders"})
    end

    drop_table :refinery_orders

  end

end
