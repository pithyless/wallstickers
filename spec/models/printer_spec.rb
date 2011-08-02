require 'spec_helper'

describe Printer, 'validates new Printer' do
  it { should validate_presence_of :user }
  it { should validate_presence_of :publisher }

  it 'should be valid' do
    printer = Fabricate.build(:printer)
    printer.should be_valid
    printer.save.should be_true
  end
end
