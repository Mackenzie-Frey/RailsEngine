class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :created_at,
                        :updated_at

  def self.random
    all.shuffle.pop
  end

  def self.associated_invoice_items(item_id)
    InvoiceItem.joins(:item).where("items.id=#{item_id}")
  end

  def self.associated_merchant(item_id)
    Merchant.joins(:items, :invoices).where("items.id=#{item_id}").first
  end
end
