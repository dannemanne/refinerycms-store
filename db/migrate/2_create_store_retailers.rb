class CreateStoreRetailers < ActiveRecord::Migration

  def change
    create_table :refinery_retailers do |t|
      t.string :name
      t.string :default_price_unit
      t.integer :position
      t.date :expired_at

      t.timestamps
    end

    add_index :refinery_retailers, :name
    add_index :refinery_retailers, :expired_at

  end

end
