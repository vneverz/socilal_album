class AddUsernameToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string
  	add_column :users, :fb_uid, :string 
  	add_column :users, :fb_image, :string 
  	add_column :users, :fb_token, :string 
  	add_column :users, :fb_expires_at, :string 
  end
end
