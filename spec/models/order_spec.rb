require 'spec_helper'

module StatusTransitionConfirmer
  def it_should_not_transition(prev, msg='', &blk)
    it "should not transtion from :#{prev} when #{msg}" do
      @order.status.should == prev
      blk.call(@order)
      @order.can_level_up?.should be_false
      lambda { @order.level_up! }.should raise_error(ActiveRecord::RecordInvalid)
      @order.reload.status.should == prev
    end
  end

  def it_should_transition(prev, new, msg='', &blk)
    it "should transtion from :#{prev} to #{new} (#{msg})" do
      @order.status.should == prev
      blk.call(@order)
      @order.can_level_up?.should be_true
      @order.level_up!
      @order.reload.status.should == new
    end
  end
end

describe Order, 'validates brand new Order' do
  it { should validate_presence_of :user }

  it 'should be valid' do
    order = Fabricate.build(:order)
    order.should be_valid
    order.save.should be_true
  end
end

describe Order, 'token' do
  before :each do
    @order = Fabricate(:order)
  end

  it 'should be auto-generated' do
    @order.token.should =~ /\d{6}/
  end

  it 'should be read-only' do
    old = @order.token
    new = (Integer(old) + 1).to_s
    old.should_not == new
    @order.token = new
    @order.save!
    @order.reload.token.should == old
  end
end

describe Order, 'initial' do
  before(:each) { @order = Fabricate :order }

  it 'should have initial states' do
    @order.status.should  == :waiting_confirm_address_info
    @order.paid_at.should be_nil
    @order.printed_at.should be_nil
    @order.shipped_at.should be_nil
  end
end

describe Order, 'address info' do
  extend StatusTransitionConfirmer

  before(:each) { @order = Fabricate :order }

  describe 'confirming billing info' do
    it_should_not_transition(:waiting_confirm_address_info, 'missing billing address') do |order|
      order.billing_address = nil
    end

    it_should_not_transition(:waiting_confirm_address_info, 'invalid billing address') do |order|
      order.billing_address = Address.new(:city => 'Not Valid!')
    end

    it_should_transition(:waiting_confirm_address_info, :waiting_redirect_to_payment_gateway) do |order|
      order.billing_address = Fabricate :address
    end

    it 'should save new billing address' do
      address = Fabricate.build(:address)
      address.should be_new_record
      @order.billing_address = address
      @order.level_up!
      address.should_not be_new_record
    end
  end

  describe 'confirming shipping info' do
    it_should_not_transition(:waiting_confirm_address_info, 'invalid shipping address') do |order|
      order.billing_address  = Fabricate :address
      order.shipping_address = Address.new(:city => 'Not Valid!')
    end

    it_should_transition(:waiting_confirm_address_info, :waiting_redirect_to_payment_gateway,
                         'empty shipping address') do |order|
      order.billing_address  = Fabricate :address
      order.shipping_address = nil
    end

    it_should_transition(:waiting_confirm_address_info, :waiting_redirect_to_payment_gateway) do |order|
      order.billing_address  = Fabricate :address
      order.shipping_address = Fabricate :address
    end

    it 'should save new addresses' do
      address  = Fabricate.build(:address)
      address2 = Fabricate.build(:address)
      address.should be_new_record
      address2.should be_new_record
      @order.billing_address  = address
      @order.shipping_address = address2
      @order.level_up!
      address.should_not be_new_record
      address2.should_not be_new_record
    end
  end
end

describe Order, 'stateful payment' do
  extend StatusTransitionConfirmer

  before(:each) do
    @order = Fabricate :order
    @order.billing_address = Fabricate :address
    @order.level_up!
    @order.status.should == :waiting_redirect_to_payment_gateway
  end

  describe 'redirecting to payment gateway' do
    it_should_transition(:waiting_redirect_to_payment_gateway, :waiting_callback_from_payment_gateway) do |order|
      # TODO
    end
  end

  describe 'verifying payment gateway transaction' do
    before(:each) do
      @order.level_up!
      @order.status.should == :waiting_callback_from_payment_gateway
    end

    it_should_transition(:waiting_callback_from_payment_gateway, :waiting_acceptance_by_printer) do |order|
      # TODO
    end
  end

  it 'should validate paid_at'
end

describe Order, 'stateful printing' do
  extend StatusTransitionConfirmer

  before(:each) do
    @order = Fabricate :order
    @order.billing_address = Fabricate :address
    @order.level_up!
    @order.level_up!
    @order.level_up!
    @order.status.should == :waiting_acceptance_by_printer
  end

  describe 'waiting for acceptance by printer' do
    it_should_transition(:waiting_acceptance_by_printer, :waiting_complete_printing) do |order|
      # TODO
    end
  end

  describe 'waiting for printing completion' do
    before(:each) do
      @order.level_up!
      @order.status.should == :waiting_complete_printing
    end

    it_should_transition(:waiting_complete_printing, :waiting_shipping_package) do |order|
      # TODO
    end
  end

  it 'should validate printed_at'
end

describe Order, 'stateful shipping' do
  extend StatusTransitionConfirmer

  before(:each) do
    @order = Fabricate :order
    @order.billing_address = Fabricate :address
    @order.level_up!
    @order.level_up!
    @order.level_up!
    @order.level_up!
    @order.level_up!
    @order.status.should == :waiting_shipping_package
  end

  describe 'waiting for shipping' do
    it_should_transition(:waiting_shipping_package, :finished) do |order|
      # TODO
    end
  end
end

describe Order do
  it 'should properly test finished status'
end
