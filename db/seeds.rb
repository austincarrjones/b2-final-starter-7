# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Rake::Task["csv_load:all"].invoke

merchant1 = Merchant.create!(name: "Hair Care")

item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id)
item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 20, merchant_id: merchant1.id)
item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: merchant1.id)

customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")

invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 5, unit_price: 10, status: 2)
ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 10, unit_price: 20, status: 2)
ii_3 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 30, status: 2)

transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)

bd_1 = BulkDiscount.create!(merchant_id: merchant1.id, percentage_discount: 0.2, quantity_threshold: 5)
bd_2 = BulkDiscount.create!(merchant_id: merchant1.id, percentage_discount: 0.5, quantity_threshold: 10)