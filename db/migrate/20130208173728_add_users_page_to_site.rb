class AddUsersPageToSite < ActiveRecord::Migration
  def change
    add_column :sites, :users_page_id, :integer
  end
end
