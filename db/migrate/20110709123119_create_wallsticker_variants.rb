class CreateWallstickerVariants < ActiveRecord::Migration
  def change
    create_table :wallsticker_variants do |t|
      t.integer :wallsticker_id, :null => false
      t.string  :color,          :null => false
      t.integer :width_cm,       :null => false
      t.integer :height_cm,      :null => false
      t.decimal :price_pln,      :null => false, :precision => 8, :scale => 2

      t.timestamps
    end
    add_foreign_key :wallsticker_variants, :wallstickers, :dependent => :restrict, :name => 'wallsticker_variants_wallsticker_id_fk'

    add_index :wallsticker_variants, :wallsticker_id
  end
end
