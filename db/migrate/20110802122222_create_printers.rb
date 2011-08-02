class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.integer :user_id,         :null => false
      t.integer :publisher_id,    :null => false

      t.timestamps
    end

    add_foreign_key :printers, :users, :dependent => :restrict, :name => 'printers_user_id_fk'
    add_foreign_key :printers, :publishers, :dependent => :restrict, :name => 'printers_publisher_id_fk'

    add_index :printers, :user_id, :unique => true
  end
end
