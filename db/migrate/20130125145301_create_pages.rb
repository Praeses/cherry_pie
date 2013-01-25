class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :site

      t.timestamps
    end
    add_index :pages, :site_id
  end
end
