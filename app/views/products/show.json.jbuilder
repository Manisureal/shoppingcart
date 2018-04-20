json.product do
  json.id @product.id
  json.name @product.name
  json.price @product.price
  json.description @product.description
  json.pack_size @product.pack_size
  json.product_code @product.product_code
end
