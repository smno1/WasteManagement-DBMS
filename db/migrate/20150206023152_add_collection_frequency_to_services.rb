class AddCollectionFrequencyToServices < ActiveRecord::Migration
  def change
    add_column :services, :collection_frequency, :string
  end
end
