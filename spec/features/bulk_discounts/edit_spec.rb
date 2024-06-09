require "rails_helper"

RSpec.describe "bulk_discounts edit" do
  before :each do
    @m_1 = Merchant.create!(name: "Hair Care")
    @bd_1 = BulkDiscount.create!(merchant_id: @m_1.id, percentage_discount: 0.2, quantity_threshold: 10)
    @bd_2 = BulkDiscount.create!(merchant_id: @m_1.id, percentage_discount: 0.5, quantity_threshold: 50)

    visit edit_merchant_bulk_discount_path(@m_1, @bd_1)
  end
  
  it "sees a form filled in with the items attributes" do
    expect(find_field("Percentage discount").value).to eq("0.2")
    expect(find_field("Quantity threshold").value).to eq("10")
    
    expect(find_field("Percentage discount").value).to_not eq("0.5")
    expect(find_field("Quantity threshold").value).to_not eq("50")
  end

  it "can fill in form, click submit, and redirect to that discount's show page and see updated info" do
    fill_in "Percentage discount", with: "0.45"
    fill_in "Quantity threshold", with: "25"

    click_button "Submit"

    expect(current_path).to eq merchant_bulk_discount_path(@m_1, @bd_1)
    expect(page).to have_content("Bulk Discount ##{@bd_1.id} - Percentage Discount: 45%, Quantity Threshold: 25")
  end
  
  xit "shows a flash message if not all sections are filled in" do
    fill_in "Percentage discount", with: ""
    fill_in "Quantity threshold", with: "25"

    click_button "Submit"

    expect(current_path).to eq (edit_merchant_bulk_discount_path(@m_1, @bd_1))
    expect(page).to have_content("All fields must be completed, get your act together.")
  end
end