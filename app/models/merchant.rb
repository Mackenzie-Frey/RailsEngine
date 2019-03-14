class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  validates_presence_of :name,
                        :created_at,
                        :updated_at

  def self.most_revenue(limit)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, sum(quantity*unit_price) AS revenue")
    .group(:id)
    # .where(result: "success")
    # .order(revenue: :desc)
    # .limit(limit)
  end

  def revenue_by_date(date)
    invoices.select("sum(unit_price*quantity) AS revenue")
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where(updated_at: Date.parse(date).all_day)[0]
  end
end
