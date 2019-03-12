require 'csv'

desc "Imports Customer CSV data"
  task :import_customers, [:customers]=> :environment do
    CSV.foreach('./db/csv/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
  end
  p "Customers imported!"
end

desc "Imports Merchant CSV data"
  task :import_merchants, [:merchants]=> :environment do
    CSV.foreach('./db/csv/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
  end
  p "Merchants imported!"
end

desc "Imports Invoice CSV data"
  task :import_invoices, [:invoices]=> :environment do
    CSV.foreach('./db/csv/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)
  end
  p "Invoices imported!"
end

desc "Imports Item CSV data"
  task :import_items, [:items]=> :environment do
    CSV.foreach('./db/csv/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
  end
  p "Items imported!"
end

desc "Imports Invoice Item CSV data"
  task :import_invoice_items, [:invoice_items]=> :environment do
    CSV.foreach('./db/csv/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
  end
  p "Invoice Items imported!"
end

desc "Imports Transaction CSV data"
  task :import_transactions, [:transactions]=> :environment do
    CSV.foreach('./db/csv/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
  end
  p "Transactions imported!"
end
