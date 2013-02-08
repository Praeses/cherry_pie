class AddOwnerToPage < ActiveRecord::Migration
  def change
    add_column :pages, :owner_id, :integer
  end
end
