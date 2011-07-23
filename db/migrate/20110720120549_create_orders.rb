class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id,         :null => false

      t.string  :state,           :null => false

      t.time    :paid_at
      t.time    :printed_at
      t.time    :shipped_at

      t.decimal :balance_pln,     :null => false, :precision => 8, :scale => 2

      t.timestamps
    end
    add_foreign_key :orders, :users, :dependent => :restrict, :name => 'orders_user_id_fk'

    add_index :orders, :user_id
  end
end
