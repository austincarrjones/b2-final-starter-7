class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount,
                        :quantity_threshold,
                        :merchant_id

  belongs_to :merchant
  has_many :invoices, through: :merchant
  # has_many :invoice_items, through: :invoices


  def percentage_format
    (self.percentage_discount * 100).to_i
  end
end