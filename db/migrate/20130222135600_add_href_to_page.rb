class AddHrefToPage < ActiveRecord::Migration
  def change
    add_column :pages, :href, :string
  end
end
