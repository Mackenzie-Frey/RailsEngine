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

    def self.favorite_merchant(id_params, limit = 1)
      Merchant
      .joins(invoices: :transactions)
      .where("invoices.customer_id=#{id_params}")
      .select("merchants.*, COUNT(transactions.id) AS transaction_count")
      .merge(Transaction.successful)
      .group(:id)
      .order("transaction_count DESC")
      .limit(limit)[0]
    end
end
