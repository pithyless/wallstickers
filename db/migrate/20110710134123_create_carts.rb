class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_foreign_key :carts, :users, :dependent => :restrict, :name => 'carts_user_id_fk'
    add_index :carts, :user_id, :unique => true
  end
end

