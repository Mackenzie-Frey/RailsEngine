class AllMerchantRevenueByDateSerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_revenue do |object|
    '%.2f' % (object.total_revenue / 100.0)
  end
end
