class AddAccountNumberAndNameToServices < ActiveRecord::Migration
  def change
    add_column :services, :account_number_and_name, :string
  end
end
