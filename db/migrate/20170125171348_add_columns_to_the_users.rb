class AddColumnsToTheUsers < ActiveRecord::Migration
  def change
add_column :users, :provider, :string
  	add_column :users, :uid, :string
  	add_column :users, :accesstoken, :string
	add_column :users, :refreshtoken, :string
  	add_column :users, :phone, :string
  	add_column :users, :urls, :string
  end
end
