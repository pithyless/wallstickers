require 'spec_helper'

describe Cart do
  it { should validate_presence_of :user }

  it 'should create Cart for User automatically' do
    user = Fabricate(:user)
    user.cart.should_not be_nil
    user.cart.instance_of?(Cart).should be_true
    o_id = user.cart.id
    user.reload
    user.cart.id.should == o_id
  end
end
