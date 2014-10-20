module Refinery
  module Store
    class Order < Refinery::Core::BaseModel
      self.table_name = 'refinery_orders'

      belongs_to :user,     class_name: '::Refinery::User'
      belongs_to :retailer

      attr_accessible :order_number, :reference, :total_price, :user_id, :status, :position, :retailer_id

      validates :retailer_id,   presence: true
      validates :order_number,  presence: true, uniqueness: { scope: :retailer_id }

      before_validation do
        self.price_unit = retailer.try(:default_price_unit)
      end

    end
  end
end
