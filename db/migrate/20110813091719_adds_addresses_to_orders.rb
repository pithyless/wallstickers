class AddsAddressesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :billing_address_id, :integer
    add_column :orders, :shipping_address_id, :integer

    add_foreign_key :orders, :addresses,
                    :column => :billing_address_id,
                    :dependent => :restrict, :name => 'orders_billing_address_id_fk'
    add_foreign_key :orders, :addresses,
                    :column => :shipping_address_id,
                    :dependent => :restrict, :name => 'orders_shipping_address_id_fk'
  end
end
