require "rails_helper"

RSpec.describe "bulk_discounts destroy" do
  it "can delete a discount from the index page" do
    @m_1 = Merchant.create!(name: "Hair Care")

    @bd_1 = BulkDiscount.create!(merchant_id: @m_1.id, percentage_discount: 0.2, quantity_threshold: 10)
    @bd_2 = BulkDiscount.create!(merchant_id: @m_1.id, percentage_discount: 0.5, quantity_threshold: 50)

    visit merchant_bulk_discounts_path(@m_1)
    
    expect(page).to have_content("Bulk Discount ##{@bd_1.id} - Percentage Discount: 20%, Quantity Threshold: #{10}")
    expect(page).to have_content("Bulk Discount ##{@bd_2.id} - Percentage Discount: 50%, Quantity Threshold: #{50}")
    
    within("#discount-#{@bd_1.id}") do
      click_button "Delete"
    end

    expect(current_path).to eq merchant_bulk_discounts_path(@m_1)
    expect(page).to_not have_content("Bulk Discount ##{@bd_1.id} - Percentage Discount: 20%, Quantity Threshold: #{10}")

  end

end