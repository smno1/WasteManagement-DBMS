# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create(email: '328862641@qq.com', encrypted_password: 'admin')
#rake db:seed GMAIL_USERNAME=*********@gmail.com GMAIL_PASSWORD=*******

User.destroy_all
UsersRole.delete_all
User.create(email: ENV["ADMIN_USERNAME"],user_name:"Admin", password: ENV["ADMIN_PASSWORD"], password_confirmation: ENV["ADMIN_PASSWORD"])
admin=User.find_by :email =>ENV["ADMIN_USERNAME"]
admin.add_role :admin
CollectionOfSelection.delete_all
CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Compactor')
CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Bin')
CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Liquid Waste')
CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Other')

#BaselineDatum.recalculate_baseline_data
