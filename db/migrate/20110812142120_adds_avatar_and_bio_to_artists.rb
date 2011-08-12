class AddsAvatarAndBioToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :avatar, :string
    add_column :artists, :bio,    :text
  end
end
