require 'spec_helper'

describe Order, 'validates brand new Order' do
  it { should validate_presence_of :user }
  it { should validate_presence_of :state }

  it 'should be valid' do
    order = Fabricate.build(:order)
    order.should be_valid
    order.save.should be_true
  end
end

describe Order, 'stateful payment' do
  before :each do
    @order = Fabricate(:order)
  end

  describe 'initial states' do
    it 'should have initial states' do
      @order.state_name.should  == :waiting_confirm_address_info
      @order.paid_at.should be_nil
      @order.printed_at.should be_nil
      @order.shipped_at.should be_nil
    end
  end

  describe 'confirming billing info' do

    it 'should confirm address info' do
      @order.state_name.should  == :waiting_confirm_address_info
      @order.confirmed_address_info.should be_true
      @order.state_name.should  == :waiting_redirect_to_payment_gateway
    end

    it 'should validate address info'
  end

  describe 'redirecting to payment gateway' do
    it 'should redirect to gateway' do
      @order.confirmed_address_info!
      @order.redirected_to_payment_gateway.should be_true
      @order.state_name.should  == :waiting_callback_from_payment_gateway
    end
  end

  describe 'verifying payment gateway transaction' do
    it 'should verify payment gateway transaction' do
      @order.confirmed_address_info!
      @order.redirected_to_payment_gateway!
      @order.verified_payment_gateway_transaction.should be_true
      @order.state_name.should  == :waiting_acceptance_by_printer
    end

    it 'should validate paid_at'
  end
end

describe Order, 'stateful printing' do
  before :each do
    @order = Fabricate(:order)
    @order.confirmed_address_info!
    @order.redirected_to_payment_gateway!
    @order.verified_payment_gateway_transaction!
  end

  describe 'waiting for acceptance by printer' do
    it 'should be accepted by printer' do
      @order.accepted_by_printer.should be_true
      @order.state_name.should  == :waiting_complete_printing
    end
  end

  describe 'waiting for printing completion' do
    it 'should be printed' do
      @order.accepted_by_printer!
      @order.completed_printing.should be_true
      @order.state_name.should  == :waiting_shipping_package
    end

    it 'should validate printed_at'
  end
end

describe Order, 'stateful shipping' do
  before :each do
    @order = Fabricate(:order)
    @order.confirmed_address_info!
    @order.redirected_to_payment_gateway!
    @order.verified_payment_gateway_transaction!
    @order.accepted_by_printer!
    @order.completed_printing!
  end

  describe 'waiting for shipping package' do
    it 'should be shipped' do
      @order.shipped_package.should be_true
      @order.state_name.should  == :finished
    end

    it 'should validate shipped_at'

    it 'should validate order is marked finished'
  end
end
