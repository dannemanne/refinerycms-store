# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Store" do
    describe "store" do

      describe "products list" do
        let(:retailer) { FactoryGirl.create(:retailer) }
        before do
          FactoryGirl.create(:product, :product_number => "UniqueTitleOne", retailer: retailer)
          FactoryGirl.create(:product, :product_number => "UniqueTitleTwo")
          FactoryGirl.create(:product, :product_number => "UniqueTitleThree", expired_at: Date.yesterday, featured_at: Date.yesterday, retailer: retailer)
          FactoryGirl.create(:product, :product_number => "UniqueTitleFour", featured_at: Date.yesterday, retailer: retailer)
        end

        it "only shows product that are not expired" do
          visit refinery.store_store_path
          page.should have_content("UniqueTitleOne")
          page.should have_content("UniqueTitleTwo")
          page.should_not have_content("UniqueTitleThree")
          page.should have_content("UniqueTitleFour")
        end

        it "only shows non-expired, featured products when scope is featured" do
          visit refinery.store_store_path(scope: 'featured')
          page.should_not have_content("UniqueTitleOne")
          page.should_not have_content("UniqueTitleTwo")
          page.should_not have_content("UniqueTitleThree")
          page.should have_content("UniqueTitleFour")
        end

        it "only shows non-expired products from a specific retailer" do
          visit refinery.store_store_path(retailer_id: retailer.id)
          page.should have_content("UniqueTitleOne")
          page.should_not have_content("UniqueTitleTwo")
          page.should_not have_content("UniqueTitleThree")
          page.should have_content("UniqueTitleFour")
        end
      end

    end
  end
end
