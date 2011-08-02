class AddsTokenToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :token, :string, :null => false
    add_index  :orders, :token, :unique => true
  end
end
