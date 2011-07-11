class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer  :cart_id
      t.integer  :wallsticker_variant_id

      t.timestamps
    end
  end
end
