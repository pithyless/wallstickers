class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :slug, :null => false
      t.string :name, :null => false

      t.timestamps
    end

    add_index :publishers, :slug, :unique => true
  end
end
