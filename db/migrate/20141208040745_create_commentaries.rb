class CreateCommentaries < ActiveRecord::Migration
  def change
    create_table :commentaries do |t|
      t.text :comments
      t.date :month
      t.references :site
      t.timestamps
    end
  end
end
