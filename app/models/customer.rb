class Customer < ApplicationRecord
  has_many :invoices
  validates_presence_of :first_name,
                        :last_name,
                        :created_at,
                        :updated_at

    def self.random
      all.shuffle.pop
    end
end
