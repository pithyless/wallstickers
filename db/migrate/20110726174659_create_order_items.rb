class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.integer :user_id
      t.integer :order_id
      t.integer :wallsticker_variant_id,  :null => false

      t.timestamps
    end

    add_foreign_key :order_items, :users, :dependent => :restrict, :name => 'order_items_user_id_fk'
    add_foreign_key :order_items, :orders, :dependent => :restrict, :name => 'order_items_order_id_fk'

    execute <<-EOS
      ALTER TABLE order_items ADD CONSTRAINT check_order_or_user
                              CHECK ((order_id is not null AND user_id is null)
                                 OR  (order_id is null     AND user_id is not null))
    EOS
  end

  def self.down
    drop_table :order_items
  end
end
