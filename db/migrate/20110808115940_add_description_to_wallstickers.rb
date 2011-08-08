class AddDescriptionToWallstickers < ActiveRecord::Migration
  def change
    add_column :wallstickers, :description, :text
  end
end
