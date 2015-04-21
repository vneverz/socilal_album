class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.boolean :is_public
      t.text :content
      t.integer :user_id
      t.integer :comments_count

      t.timestamps null: false
    end
    add_index :photos, :user_id
  end
end
