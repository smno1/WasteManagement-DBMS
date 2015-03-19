# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#rake db:seed GMAIL_USERNAME=*********@gmail.com GMAIL_PASSWORD=*******

#User.destroy_all
#UsersRole.delete_all
#User.create(email: ENV["ADMIN_USERNAME"],user_name:"Admin", password: ENV["ADMIN_PASSWORD"], password_confirmation: ENV["ADMIN_PASSWORD"])
#admin=User.find_by :email =>ENV["ADMIN_USERNAME"]
#admin.add_role :admin
#CollectionOfSelection.delete_all
#CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Compactor')
#CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Bin')
#CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Liquid Waste')
#CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Other')

#every fy attribute only be updated when sabs are created or changed or deleted
sites=Site.all
sites.each do |s|
  s.update_fy_cost
  s.update_fy_saving
  s.update_running_total
end
