class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount,
                        :quantity_threshold
  belongs_to :merchant

  def percentage_format
    (self.percentage_discount * 100).to_i
  end
end