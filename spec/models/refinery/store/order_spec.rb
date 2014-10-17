require 'spec_helper'

module Refinery
  module Store
    describe Order do
      describe "validations" do
        subject do
          FactoryGirl.create(:order,
          :order_number => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:order_number) { should == "Refinery CMS" }
      end
    end
  end
end
