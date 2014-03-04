# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Sku.create(code: 'S2-01A', name: 'Season To - Artisan - 1 Month Subscription', unit_price: '29.00')
Sku.create(code: 'S2-01F', name: 'Season To - Flip - 1 Month Subscription', unit_price: '23.00')
Sku.create(code: 'S2-01P', name: 'Season To - Pouch - 1 Month Subscription', unit_price: '19.00')

Sku.create(code: 'S2-03A', name: 'Season To - Artisan - 3 Month Subscription', unit_price: '84.00')
Sku.create(code: 'S2-03F', name: 'Season To - Flip - 3 Month Subscription', unit_price: '66.00')
Sku.create(code: 'S2-03P', name: 'Season To - Pouch - 3 Month Subscription', unit_price: '54.00')

Sku.create(code: 'S2-06A', name: 'Season To - Artisan - 6 Month Subscription', unit_price: '162.00')
Sku.create(code: 'S2-06F', name: 'Season To - Flip - 6 Month Subscription', unit_price: '126.00')
Sku.create(code: 'S2-06P', name: 'Season To - Pouch - 6 Month Subscription', unit_price: '102.00')

Sku.create(code: 'S2-12A', name: 'Season To - Artisan - 12 Month Subscription', unit_price: '312.00')
Sku.create(code: 'S2-12F', name: 'Season To - Flip - 12 Month Subscription', unit_price: '240.00')
Sku.create(code: 'S2-12P', name: 'Season To - Pouch - 12 Month Subscription', unit_price: '192.00')




Product.create(name: 'Season To Gift Subscription', description: 'A delightful selection of gourmet salt and pepper curated by professional chefs delivered to your friends doorstep every month.')
Sku.create(code: 'S2-GIF-01', name: 'Season To - Gift - 1 Month Subscription', unit_price: '19.00', product: Product.find_by_name('Season To Gift Subscription'))
Sku.create(code: 'S2-GIF-03', name: 'Season To - Gift - 3 Month Subscription', unit_price: '54.00', product: Product.find_by_name('Season To Gift Subscription'))
Sku.create(code: 'S2-GIF-06', name: 'Season To - Gift - 6 Month Subscription', unit_price: '102.00', product: Product.find_by_name('Season To Gift Subscription'))
Sku.create(code: 'S2-GIF-12', name: 'Season To - Gift - 12 Month Subscription', unit_price: '192.00', product: Product.find_by_name('Season To Gift Subscription'))

Plan.create(code: 'SEASON-TO-1-MONTH-GIFT', name: '1 Month - Gift', price: '19.00', billing_cycle: 1, sku: Sku.find_by_code('S2-GIF-01'))
Plan.create(code: 'SEASON-TO-3-MONTH-GIFT', name: '3 Month - Gift', price: '54.00', billing_cycle: 3, sku: Sku.find_by_code('S2-GIF-03'))
Plan.create(code: 'SEASON-TO-6-MONTH-GIFT', name: '6 Month - Gift', price: '102.00', billing_cycle: 6, sku: Sku.find_by_code('S2-GIF-06'))
Plan.create(code: 'SEASON-TO-12-MONTH-GIFT', name: '12 Month - Gift', price: '192.00', billing_cycle: 12, sku: Sku.find_by_code('S2-GIF-12'))


Plan.create(code: 'SEASON-TO-1-MONTH-ARTISAN', name: '1 Month - Artisan', price: '29.00', billing_cycle: 1, sku: Sku.find_by_code('S2-01A'))
Plan.create(code: 'SEASON-TO-3-MONTH-ARTISAN', name: '3 Month - Artisan', price: '84.00', billing_cycle: 3, sku: Sku.find_by_code('S2-03A'))
Plan.create(code: 'SEASON-TO-6-MONTH-ARTISAN', name: '6 Month - Artisan', price: '162.00', billing_cycle: 6, sku: Sku.find_by_code('S2-06A'))
Plan.create(code: 'SEASON-TO-12-MONTH-ARTISAN', name: '12 Month - Artisan', price: '312.00', billing_cycle: 12, sku: Sku.find_by_code('S2-12A'))


Plan.create(code: 'SEASON-TO-1-MONTH-FLIP', name: '1 Month - Flip', price: '23.00', billing_cycle: 1, sku: Sku.find_by_code('S2-01F'))
Plan.create(code: 'SEASON-TO-3-MONTH-FLIP', name: '3 Month - Flip', price: '66.00', billing_cycle: 3, sku: Sku.find_by_code('S2-03F'))
Plan.create(code: 'SEASON-TO-6-MONTH-FLIP', name: '6 Month - Flip', price: '126.00', billing_cycle: 6, sku: Sku.find_by_code('S2-06F'))
Plan.create(code: 'SEASON-TO-12-MONTH-FLIP', name: '12 Month - Flip', price: '240.00', billing_cycle: 12, sku: Sku.find_by_code('S2-12F'))

Plan.create(code: 'SEASON-TO-1-MONTH-POUCH', name: '1 Month - Pouch', price: '19.00', billing_cycle: 1, sku: Sku.find_by_code('S2-01P'))
Plan.create(code: 'SEASON-TO-3-MONTH-POUCH', name: '3 Month - Pouch', price: '54.00', billing_cycle: 3, sku: Sku.find_by_code('S2-03P'))
Plan.create(code: 'SEASON-TO-6-MONTH-POUCH', name: '6 Month - Pouch', price: '102.00', billing_cycle: 6, sku: Sku.find_by_code('S2-06P'))
Plan.create(code: 'SEASON-TO-12-MONTH-POUCH', name: '12 Month - Pouch', price: '192.00', billing_cycle: 12, sku: Sku.find_by_code('S2-12P'))
