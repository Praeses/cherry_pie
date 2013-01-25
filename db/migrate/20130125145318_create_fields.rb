class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :page
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :fields, :page_id
  end
end
