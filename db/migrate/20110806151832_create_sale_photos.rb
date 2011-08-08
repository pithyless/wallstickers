class CreateSalePhotos < ActiveRecord::Migration
  def change
    create_table :sale_photos do |t|
      t.integer :wallsticker_id, :null => false
      t.string  :image,          :null => false

      t.timestamps
    end
    add_foreign_key :sale_photos, :wallstickers, :name => 'sale_photos_wallsticker_id_fk'

    add_index :sale_photos, :wallsticker_id
  end
end
