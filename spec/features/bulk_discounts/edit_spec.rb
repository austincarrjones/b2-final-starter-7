require "rails_helper"

RSpec.describe "bulk_discounts edit" do
  before :each do
    @m_1 = Merchant.create!(name: "Hair Care")
    @bd_1 = BulkDiscount.create!(merchant_id: @m_1.id, percentage_discount: 0.2, quantity_threshold: 10)
    @bd_2 = BulkDiscount.create!(merchant_id: @m_1.id, percentage_discount: 0.5, quantity_threshold: 50)

    visit edit_merchant_bulk_discount_path(@m_1, @bd_1)
  end
  
  xit "sees a form filled in with the items attributes" do
    expect(find_field("Percentage discount").value).to eq(@bd_1.percentage_discount)
    expect(find_field("Quantity Threshold").value).to eq(@bd_1.quantity_threshold)
    
    expect(find_field("Percentage discount").value).to_not eq(@bd_2.percentage_discount)
  end

  xit "can fill in form, click submit, and redirect to that discount's show page and see updated info" do
    fill_in "Percentage discount", with: "0.45"
    fill_in "Quantity threshold", with: "25"
    click_button "Submit"

    expect(current_path).to eq merchant_bulk_discount_path(@m_1, @bd_1)
    expect(page).to have_content("Bulk Discount ##{@bd_1.id} - Percentage Discount: 45%, Quantity Threshold: 25")

  end
  
end