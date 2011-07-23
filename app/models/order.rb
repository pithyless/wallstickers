class Order < ActiveRecord::Base
  belongs_to :user

  attr_accessible nil

  validates :user,           :presence => true
  validates :state,          :presence => true
  validates :balance_pln,    :presence => true, :numericality => true

  state_machine :state, :initial => :waiting_confirm_address_info do
    event :confirmed_address_info do
      transition :waiting_confirm_address_info => :waiting_redirect_to_payment_gateway
    end

    event :redirected_to_payment_gateway do
      transition :waiting_redirect_to_payment_gateway => :waiting_callback_from_payment_gateway
    end
  end

  state_machine :shipped_at, :initial => :pending, :namespace => 'shipment' do
    event :deliver do
      transition :pending => :shipped
    end
    
    state :pending, :value => nil
    state :shipped, :if => lambda {|value| value}, :value => lambda {Time.now}
  end
end
