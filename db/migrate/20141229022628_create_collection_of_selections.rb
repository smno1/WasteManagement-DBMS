class CreateCollectionOfSelections < ActiveRecord::Migration
  def change
    create_table :collection_of_selections do |t|
      t.string :selection_type
      t.string :selection_item
      t.timestamps
    end
  end
end
