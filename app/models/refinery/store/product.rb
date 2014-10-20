module Refinery
  module Store
    class Product < Refinery::Core::BaseModel
      self.table_name = 'refinery_products'

      belongs_to :retailer

      attr_accessible :product_number, :name, :description, :measurement_unit, :price_amount, :image_id, :position, :retailer_id

      validates :retailer_id,       presence: true
      validates :product_number,    presence: true, uniqueness: { scope: :retailer_id }
      validates :name,              presence: true
      validates :measurement_unit,  presence: true
      validates :price_amount,      presence: true

      before_validation do
        self.price_unit = retailer.try(:default_price_unit)
      end

      def price
        "#{price_amount} #{price_unit}"
      end

      class << self
        def not_expired
          where("#{table_name}.expired_at IS NULL")
        end
        def featured
          where("#{table_name}.featured_at IS NOT NULL").order("#{table_name}.featured_at DESC")
        end
      end

    end
  end
end
