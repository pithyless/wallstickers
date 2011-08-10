class AddsCategoryToWallstickers < ActiveRecord::Migration
  def change
    add_column :wallstickers, :category_id, :integer, :null => false
    add_foreign_key :wallstickers, :categories, :dependent => :restrict, :name => 'wallstickers_category_id_fk'
  end
end
