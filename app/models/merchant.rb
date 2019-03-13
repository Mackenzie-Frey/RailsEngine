class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  validates_presence_of :name,
                        :created_at,
                        :updated_at

  def self.most_revenue(n)
  end
end
