class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :order_items

  attr_accessible nil
  attr_readonly :token

  validates :user,           :presence => true
  validates :state,          :presence => true
  validates :balance_pln,    :presence => true, :numericality => true

  before_validation :calculate_balance_pln
  before_create :generate_token

  def calculate_balance_pln
    # TODO: this needs to also trigger whenever associated order_items change
    write_attribute :balance_pln, order_items.map{ |i| i.price_pln }.sum
  end

  def generate_token
    # TODO: move this generator to PostgreSQL to avoid race condition
    r = Random.new
    tok = r.rand(10**5...10**6).to_s
    while Order.find_by_token(tok)
      tok = r.rand(10**5...10**6).to_s
    end
    write_attribute :token, tok
  end

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
