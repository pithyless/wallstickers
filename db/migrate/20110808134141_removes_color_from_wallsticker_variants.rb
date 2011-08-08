class RemovesColorFromWallstickerVariants < ActiveRecord::Migration
  def up
    remove_column :wallsticker_variants, :color
  end

  def down
    raise IrreversibleMigration
  end
end
