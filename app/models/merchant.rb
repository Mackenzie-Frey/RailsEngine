class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  validates_presence_of :name,
                        :created_at,
                        :updated_at
  def self.random
    all.shuffle.pop
  end

  def self.most_revenue(limit)
    select("merchants.*, sum(quantity*unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .group(:id).merge(Transaction.successful)
    .order("revenue DESC")
    .limit(limit)
  end

  def revenue_by_date(date)
    invoices.select("sum(unit_price*quantity) AS revenue")
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where(updated_at: Date.parse(date).all_day)[0]
  end

  def self.most_items(limit)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(quantity) AS total_quantity")
    .group(:id)
    .merge(Transaction.successful)
    .order("total_quantity DESC")
    .limit(limit)
  end

  def self.favorite_customer(limit = 1, id_params)
    Customer
    .select("customers.*, COUNT(transactions.id) AS total_transactions")
    .joins(invoices: [:transactions])
    .where("invoices.merchant_id=#{id_params}")
    .merge(Transaction.successful)
    .group(:id)
    .order("total_transactions DESC")
    .limit(limit)[0]
  end
end
