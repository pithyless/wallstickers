class AddSourceImageToWallsticker < ActiveRecord::Migration
  def change
    add_column :wallstickers, :source_image, :string, :null => false
  end
end
