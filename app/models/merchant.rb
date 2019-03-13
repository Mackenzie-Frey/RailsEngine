class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  validates_presence_of :name,
                        :created_at,
                        :updated_at

  def self.most_revenue(n)
    # binding.pry
    # joins(:invoices)
    # .joins("transactions ON invoices.id=transactions.invoice_id")

    # joins(invoice_items: :transactions)
    # sum(:quantity * :unit_price AS :revenue)
    # .where(result: "success")
    # .order(revenue: :desc)
    # .limit(n)
  end
end
