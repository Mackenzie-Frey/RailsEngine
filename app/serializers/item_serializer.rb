class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description, :id, :name, :merchant_id, :unit_price
end
