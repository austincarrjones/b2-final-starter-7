require "rails_helper"

RSpec.describe "bulk_discounts index" do
  before :each do
    @m_1 = Merchant.create!(name: "Hair Care")
    @m_2 = Merchant.create!(name: "Dog Care")
    
    @bd_1 = BulkDiscount.create!(merchant_id: @m_1.id, percentage_discount: 0.2, quantity_threshold: 10)
    @bd_2 = BulkDiscount.create!(merchant_id: @m_1.id, percentage_discount: 0.5, quantity_threshold: 50)
    @bd_3 = BulkDiscount.create!(merchant_id: @m_2.id, percentage_discount: 0.5, quantity_threshold: 50)

    visit merchant_bulk_discounts_path(@m_1)
  end

  it "should list all my bulk discounts bulk discounts including their discount and thresholds" do
    expect(page).to have_content("Bulk Discount ##{@bd_1.id} - Percentage Discount: 20%, Quantity Threshold: #{10}")
    expect(page).to have_content("Bulk Discount ##{@bd_2.id} - Percentage Discount: 50%, Quantity Threshold: #{50}")
    expect(page).to_not have_content("Bulk Discount ##{@bd_3.id}")
  end

  it "should list all my bulk discounts as links to their show page" do
    expect(page).to have_link("Bulk Discount ##{@bd_1.id}")
    expect(page).to have_link("Bulk Discount ##{@bd_2.id}")

    click_link("Bulk Discount ##{@bd_1.id}")
    expect(current_path).to eq merchant_bulk_discount_path(@m_1, @bd_1)
  end

  it "should have a link to create a new discount on a new page" do 
    expect(page).to have_link("Create New Discount")

    click_link("Create New Discount")
    expect(current_path).to eq new_merchant_bulk_discount_path(@m_1)
  end

  #probably put in describe block or put on new_spec.rb file
  it "should redirect to bulk discount index and have new discount listed after form completion and submission" do
    expect(page).to_not have_content("Percentage Discount: 30%")
    expect(page).to_not have_content("Quantity Threshold: 15")
    
    click_link("Create New Discount")
    # save_and_open_page
    fill_in "Percentage discount", with: "0.3"
    fill_in "Quantity threshold", with: "15"
    click_button "Submit"

    expect(current_path).to eq merchant_bulk_discounts_path(@m_1)
    expect(page).to have_content("Percentage Discount: 30%")
    expect(page).to have_content("Quantity Threshold: 15")
  end
end