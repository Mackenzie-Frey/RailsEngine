require 'csv'

desc "Imports Customer, Merchant, Invoice, Item, Invoice Item & Transaction CSVs"
  task :import_all, [:all]=> :environment do
    CSV.foreach('./db/csv/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
    p "Customers imported!"

    CSV.foreach('./db/csv/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
    p "Merchants imported!"

    CSV.foreach('./db/csv/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
    p "Invoices imported!"

    CSV.foreach('./db/csv/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
    end
    p "Items imported!"

    CSV.foreach('./db/csv/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    p "Invoice Items imported!"

    CSV.foreach('./db/csv/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
    p "Transactions imported!"
end
