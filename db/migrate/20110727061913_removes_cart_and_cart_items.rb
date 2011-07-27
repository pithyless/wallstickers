class RemovesCartAndCartItems < ActiveRecord::Migration
  def up
    drop_table :cart_items
    drop_table :carts
  end

  def down
    raise IrreversibleMigration
  end
end
