class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.integer :user_id, :null => false
      t.decimal :balance, :precision => 8, :scale => 2, :null => false, :default => 0

      t.timestamps
    end

    add_foreign_key :artists, :users, :dependent => :restrict, :name => 'talents_user_id_fk'
    add_index :artists, :user_id, :unique => true
  end
end
