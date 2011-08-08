class AddColorsToWallsticker < ActiveRecord::Migration
  def change
    add_column :wallstickers, :colors, :string
  end
end
