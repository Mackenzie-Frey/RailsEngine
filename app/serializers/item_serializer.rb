class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description, :id, :name, :merchant_id, :unit_price
  attribute :unit_price do |object|
    '%.2f' % (object[:unit_price].to_i / 100.0)
  end
end
