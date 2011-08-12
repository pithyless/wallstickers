class AddBrowseImageToWallsticker < ActiveRecord::Migration
  def change
    add_column :wallstickers, :browse_image, :string
  end
end
