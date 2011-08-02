# -*- coding: utf-8 -*-
require 'spec_helper'

describe Publisher do
  it { should validate_presence_of :slug }
  it { should validate_presence_of :name }

  it 'should be valid' do
    model = Fabricate.build(:publisher)
    model.should be_valid
    model.save.should be_true
  end

  describe "uniqueness" do
    before { @publisher = Fabricate(:publisher).save! }
    it { should validate_uniqueness_of(:slug) }
  end

  describe 'slug' do
    it 'should be set from name' do
      publisher = Fabricate.build(:publisher)
      publisher.name = 'Dropkick Murphy & Friends, Co.'
      publisher.save!
      publisher.slug.should == 'dropkick-murphy-friends-co'
    end

    it 'can be overwrriten' do
      publisher = Fabricate(:publisher, :name => 'Foo')
      publisher.slug.should == 'foo'
      publisher.slug = 'foo-bar-baz'
      publisher.save!
      publisher.reload.slug.should == 'foo-bar-baz'
    end

    it 'only accepts ascii and numbers' do
      publisher = Fabricate.build(:publisher)
      publisher.should be_valid
      ['a9+foo', 'sdęsdf', 'oNe'].each do |v|
        publisher.slug = v
        publisher.should_not be_valid, "Slug: #{v}"
      end

      ['foo-033-bar'].each do |v|
        publisher.slug = v
        publisher.should be_valid, "Slug: #{v}"
      end
    end
  end
end

describe Publisher, 'Fabrication' do
  before :each do
    @publisher = Fabricate(:publisher)
  end

  it 'should have one printer' do
    @publisher.printers.count.should == 1
    @publisher.printers[0].should be_an_instance_of(Printer)
  end
end
