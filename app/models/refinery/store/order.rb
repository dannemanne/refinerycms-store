module Refinery
  module Store
    class Order < Refinery::Core::BaseModel
      self.table_name = 'refinery_orders'

      attr_accessible :order_number, :reference, :quantity, :unit, :user_id, :status, :position

      validates :order_number, :presence => true, :uniqueness => true
    end
  end
end
