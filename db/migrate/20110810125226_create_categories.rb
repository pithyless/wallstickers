class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :slug, :null => false
      t.string :name, :null => false

      t.timestamps
    end
    add_index :categories, :slug, :unique => true
  end
end
