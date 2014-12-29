# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


selection_items=CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Compactor')
selection_items=CollectionOfSelection.create(selection_type: 'bin_type', selection_item: 'Bin')
