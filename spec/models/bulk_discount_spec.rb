require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe "validations" do
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_presence_of :merchant_id }
  end
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:invoices).through(:merchant) }
    # it { should have_many(:invoice_items).through(:invoices) }
  end

  describe "instance methods" do
    it "percentage_format" do
      m_1 = Merchant.create!(name: "Hair Care")
      bd_1 = BulkDiscount.create!(merchant_id: m_1.id, percentage_discount: 0.2, quantity_threshold: 10)

      expect(bd_1.percentage_format).to eq(20)
    end
  end
end
