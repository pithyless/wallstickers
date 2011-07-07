class Wallsticker < ActiveRecord::Base
  concerned_with :validation

  belongs_to :artist

  attr_accessible :title
end
