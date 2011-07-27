require 'spec_helper'

describe Cart, 'new' do
  it 'should require user' do
    lambda { Cart.new }.should raise_error
    lambda { Cart.new('not_a_user') }.should raise_error
    Cart.new(Fabricate(:user)).should_not be_nil # OK
  end

  it 'should be empty?' do
    cart = Cart.new(Fabricate(:user))
    cart.should be_empty
    cart.size.should == 0
  end
end

describe 'Shopping for wallstickers' do
  before :each do
    @user  = Fabricate(:user)
    @one   = Fabricate(:wallsticker_variant, :price_pln => 10)
    @two   = Fabricate(:wallsticker_variant, :price_pln => 20)
    @three = Fabricate(:wallsticker_variant, :price_pln => 40)
    @four  = Fabricate(:wallsticker_variant, :price_pln => 100)
  end

  describe 'adding one' do
    before :each do
      @user.cart.add_item @one
    end

    it 'should have item' do
      @user.cart.items.map(&:variant).should == [@one]
    end

    it { @user.cart.should_not be_empty }
    it { @user.cart.size.should == 1 }
    it { @user.cart.balance_pln.should == 10}
  end

  describe 'adding three' do
    before :each do
      @user.cart.add_item @one
      @user.cart.add_item @two
      @user.cart.add_item @three
    end

    it 'should have items' do
      @user.cart.items.map(&:variant).should == [@three, @two, @one]
    end

    it { @user.cart.should_not be_empty }
    it { @user.cart.size.should == 3 }
    it { @user.cart.balance_pln.should == 70}
  end

  describe 'ordering three items' do
    before :each do
      @user.cart.add_item @one
      @user.cart.add_item @two
      @user.cart.add_item @three
      @order = @user.cart.checkout_order!
    end

    it 'should checkout Order' do
      @order.should be_an_instance_of(Order)
    end

    it 'should empty cart' do
      @user.cart.should be_empty
      @user.cart.balance_pln.should == 0
    end

    it 'should add items to Order' do
      @order.should be_an_instance_of(Order)
      @order.order_items.all.map { |x| x.variant.id }.sort.should == [@three.id, @two.id, @one.id].sort
      @order.order_items.map do |i|
        i.user.should be_nil
        i.order.should == @order
      end
    end
  end
end
