class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :order_items

  belongs_to :billing_address,  :class_name => 'Address', :foreign_key => 'billing_address_id'
  belongs_to :shipping_address, :class_name => 'Address', :foreign_key => 'shipping_address_id'

  attr_accessible nil
  attr_readonly :token

  concerned_with :statefulness, :validation

  # TODO: set paid_at, printed_at, and shipped_at

  def to_param
    token
  end

  # -- Finders --

  def self.new_order!(user, checkout_items)
    order = Order.new
    order.user = user
    order.transaction do
      # TODO: this is ugly
      checkout_items.map do |variant|
        variant.user = nil
        variant.order = order
        variant.save!
      end
      order.save!
    end
    order
  end
end
