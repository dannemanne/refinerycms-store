class CreateStoreOrders < ActiveRecord::Migration

  def up
    create_table :refinery_orders do |t|
      t.integer :retailer_id
      t.string :order_number
      t.string :reference
      t.decimal :total_price,           null: false, default: 0, scale: 2, precision: 10
      t.string :price_unit
      t.integer :user_id
      t.string :status
      t.integer :position

      t.timestamps
    end

    add_index :refinery_orders, :retailer_id
    add_index :refinery_orders, :order_number

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-store"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/store/orders"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/store"})
    end

    drop_table :refinery_orders

  end

end
