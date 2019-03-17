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
end
