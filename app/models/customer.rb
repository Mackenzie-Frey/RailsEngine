class Customer < ApplicationRecord
  has_many :invoices
  validates_presence_of :first_name,
                        :last_name,
                        :created_at,
                        :updated_at

    def self.random
      all.shuffle.pop
    end

    def self.find_transactions(customer_id)
      select("transactions.*")
      .joins(invoices: :transactions)
      .where(id: customer_id)
    end
end
