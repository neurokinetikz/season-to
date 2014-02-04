# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Sku.create(code: 'S2-01', name: 'Season To - 1 Month Subscription', unit_price: '15.00')
Sku.create(code: 'S2-03', name: 'Season To - 3 Month Subscription', unit_price: '40.00')
Sku.create(code: 'S2-06', name: 'Season To - 6 Month Subscription', unit_price: '70.00')
Sku.create(code: 'S2-12', name: 'Season To - 12 Month Subscription', unit_price: '100.00')

Plan.create(code: 'SEASON-TO-1-MONTH', name: '1 Month', price: '15.00', billing_cycle: 1, sku: Sku.find_by_code('S2-01'))
Plan.create(code: 'SEASON-TO-3-MONTH', name: '3 Month', price: '40.00', billing_cycle: 3, sku: Sku.find_by_code('S2-03'))
Plan.create(code: 'SEASON-TO-6-MONTH', name: '6 Month', price: '70.00', billing_cycle: 6, sku: Sku.find_by_code('S2-06'))
Plan.create(code: 'SEASON-TO-12-MONTH', name: '12 Month', price: '100.00', billing_cycle: 12, sku: Sku.find_by_code('S2-12'))
