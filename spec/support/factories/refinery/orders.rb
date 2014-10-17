
FactoryGirl.define do
  factory :order, :class => Refinery::Store::Order do
    sequence(:order_number) { |n| "refinery#{n}" }
  end
end

