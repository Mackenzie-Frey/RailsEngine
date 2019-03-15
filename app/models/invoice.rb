class Invoice < ApplicationRecord
  enum status: ["shipped"]

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items

  validates_presence_of :status,
                        :created_at,
                        :updated_at

# Fully funcional method, not a part of project spec.
  # def self.most_expensive(limit = 5)
  #   Invoice.select("invoices.*, sum(quantity*unit_price) AS revenue")
  #   .joins(:invoice_items, :transactions)
  #   .merge(Transaction.successful)
  #   .group(:id)
  #   .order("revenue DESC")
  #   .limit(limit)
  # end
end
