class CreateWallstickers < ActiveRecord::Migration
  def change
    create_table :wallstickers do |t|
      t.integer :artist_id, :null => false

      t.string :title,      :null => false
      t.string :permalink,  :null => false

      t.timestamps
    end

    add_foreign_key :wallstickers, :artists, :dependent => :restrict, :name => 'wallstickers_artist_id_fk'

    add_index :wallstickers, :artist_id
    add_index :wallstickers, :permalink, :unique => true
  end
end
