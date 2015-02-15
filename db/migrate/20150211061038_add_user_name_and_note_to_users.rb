class AddUserNameAndNoteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string
    add_column :users, :note, :string
  end
end
