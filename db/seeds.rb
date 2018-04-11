# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.delete_all
Product.create name: "Trays", price: 5, description: "Best Trays", pack_size: 5, product_code: "SKU52104"
Product.create name: "Bins", price: 10, description: "One Bins", pack_size: 10, product_code: "SKU52235"
Product.create name: "Papers", price: 8, description: "Few Papers", pack_size: 15, product_code: "SKU65421"
Product.create name: "Clips", price: 6, description: "Dozen Clips", pack_size: 20, product_code: "SKU89562"
Product.create name: "Multis", price: 4, description: "Multis in the form", pack_size: 12, product_code: "SKU29561"
Product.create name: "Unities", price: 12, description: "Unities paper forms", pack_size: 18, product_code: "SKU74815"
