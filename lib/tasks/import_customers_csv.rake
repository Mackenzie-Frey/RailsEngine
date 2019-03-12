require 'csv'

desc "Imports a CSV file with customer data"
  task :import_customers, [:customers]=> :environment do
    CSV.foreach('./db/csv/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
  end
  p "Customers imported!"
end
