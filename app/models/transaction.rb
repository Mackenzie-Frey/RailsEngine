class Transaction < ApplicationRecord
  enum result: ["failed", "success"]
  belongs_to :invoice

  validates_presence_of :credit_card_number,
                        :result,
                        :created_at,
                        :updated_at

  scope :successful, -> { where(result: "success") }

    def self.random
      all.shuffle.pop
    end
end
