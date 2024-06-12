class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discount
    # binding.pry
    total_discount = 0
    temp_table = invoice_items
                .joins(:bulk_discounts)
                .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
                .select("invoice_items.id, MAX(bulk_discounts.percentage_discount) as max_percentage_discount, 
                      (invoice_items.quantity * invoice_items.unit_price * MAX(bulk_discounts.percentage_discount)) as discount_value")
                .group("invoice_items.id")
    temp_table.each do |row|
      total_discount += row.discount_value
    end
    total_discount
  end

  def total_discounted_revenue
    total_revenue - total_discount
  end
  
  def bulk_discount_applied
    temp_table = invoice_items
                .joins(:bulk_discounts)
                .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
                .select("invoice_items.id as ii_id, bulk_discounts.id as bd_id, 
                        MAX(bulk_discounts.percentage_discount) as max_percentage_discount")
                .group("invoice_items.id, bulk_discounts.id")
      binding.pry
      temp_table.each do |row|
        row.ii.id
  end
end