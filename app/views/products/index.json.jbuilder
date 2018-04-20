json.array! (@products) do |product|
  json.extract! product, :id, :name, :price, :description, :pack_size, :product_code
end
