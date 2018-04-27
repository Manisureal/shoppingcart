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


Order.delete_all
OrderItem.delete_all

Company.delete_all
Company.create name: "Caremeds", address: "CareMeds Ltd, Unit 5 Brickfield Trading Estate, Brickfield Lane, Chandlers Ford, Eastleigh", postcode: "SO53 4DR", contact_name: "John Rowley", phone: "07888945621", email: "support@caremeds.co.uk"

User.delete_all
User.create forname: "Mansoor", surname: "Zaman", email: "mansoor@caremeds.co.uk", password: "123456", password_confirmation: "123456", company_id: 5
User.create forname: "Andy", surname: "Withers", email: "andy@caremeds.co.uk", password: "456789", password_confirmation: "456789", company_id: 5
