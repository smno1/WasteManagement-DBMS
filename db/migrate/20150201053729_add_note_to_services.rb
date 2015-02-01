class AddNoteToServices < ActiveRecord::Migration
  def change
    add_column :services, :note, :string
  end
end
