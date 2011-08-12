class ProfilesController < ApplicationController
  def edit
    @artist = Artist.find_by_username!(params[:id])
  end

  def update
    @artist = Artist.find_by_username!(params[:id])

    if @artist.update_attributes(params[:artist])
      flash[:notice] = 'Profile successfully updated.'
      redirect_to artist_gallery_path(@artist)
    else
      render :action => "edit"
    end
  end
end
