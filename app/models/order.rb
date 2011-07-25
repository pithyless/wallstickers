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

    event :verified_payment_gateway_transaction do
      transition :waiting_callback_from_payment_gateway => :waiting_acceptance_by_printer
    end

    event :accepted_by_printer do
      transition :waiting_acceptance_by_printer => :waiting_complete_printing
    end

    event :completed_printing do
      transition :waiting_complete_printing => :waiting_shipping_package
    end

    event :shipped_package do
      transition :waiting_shipping_package => :finished
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
