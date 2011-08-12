class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_line,  :null => false
      t.string :street_line2
      t.string :city,         :null => false
      t.string :zipcode,      :null => false

      t.timestamps
    end
  end
end
