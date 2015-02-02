class AddWasteCompanyAndRegionToSites < ActiveRecord::Migration
  def change
    add_column :sites, :waste_company, :string
    add_column :sites, :region, :string
  end
end
