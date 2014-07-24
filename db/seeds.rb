# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Start seeding clients'

clients_data = [
  {title: :mr, first_name: 'Leon', last_name: 'Tay', email: 'leon@example.com', phone: '1234-5869', designation: 'Owner', company_name: 'Fanfill Technology', address: '50 ABC Street Singapore'},
  {title: :mr, first_name: 'Gabriel', last_name: 'Bunner', email: 'gabriel@example.com', phone: '4456-5869', designation: 'Owner', company_name: 'DualRanked', address: '50 DEF Street Malaysia'},
  {title: :mr, first_name: 'Melvin', last_name: 'Tan', email: 'melvin@example.com', phone: '4456-5869', designation: 'Owner', company_name: 'LunchKaki', address: '50 GHJF Street Malaysia'},
  {title: :ms, first_name: 'Geraldine', last_name: '-', email: 'geri.gx@example.com', phone: '4456-5869', designation: 'Owner', company_name: 'Our Cleaning Department',address: 'Blk 601, Bedok Reservoir Road, #03-512, S (470601).'},
  {title: :ms, first_name: 'Kheng', last_name: '-', email: 'Kheng@example.com', phone: '4456-5869', designation: 'Owner', company_name: 'Kheng', address: '25B Jalan Membina #04-122 Singapore 164025'}
]
clients ||= {}

clients_data.each do |client_data|
  client = Client.find_or_initialize_by(client_data)
  client.save
  clients[client.first_name.downcase.to_sym] = client
end

puts 'Clients seeded'

puts 'Start seeding admin'
Admin.first_or_create!({
   email: 'stevenyap@futureworkz.com',
   password: '123456789'
 })
puts 'Admin seeded'
