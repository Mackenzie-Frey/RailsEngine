class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity,
                        :unit_price,
                        :created_at,
                        :updated_at

  def self.revenue_by_date(date)
    joins(invoice: [:transactions])
    .select("sum(unit_price*quantity) AS total_revenue")
    .merge(Transaction.successful)
    .where(invoices: {updated_at: Date.parse(date).all_day})[0]
  end

  def self.random
    all.shuffle.pop
  end

  def self.find_invoice(invoice_item_id)
    Invoice.joins(:invoice_items).where("invoice_items.id=#{invoice_item_id}").first
  end

  def self.find_item(invoice_item_id)
    Item.joins(:invoice_items).where("invoice_items.id=#{invoice_item_id}").first
  end
end
