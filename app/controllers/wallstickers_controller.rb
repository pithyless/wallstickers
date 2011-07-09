class WallstickersController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :gallery, :show]

  def index
    @wallstickers = Wallsticker.order('created_at desc')
  end

  def gallery
    @artist = Artist.find_by_username(params[:artist]) || not_found
    @wallstickers = @artist.wallstickers.order('created_at desc')
  end

  def show
    @wallsticker = Wallsticker.find_by_permalink(params[:id]) || not_found
    @artist = @wallsticker.artist
  end

  def create
    current_user.artist || not_found
    @wallsticker = current_user.artist.wallstickers.build(params[:wallsticker])
    if @wallsticker.save
      redirect_to @wallsticker
    else
      render :action => 'new'
    end
  end

  def new
    # TODO: redirect if current_user.artist.nil?
    current_user.artist || not_found
    @wallsticker = current_user.artist.wallstickers.build()
  end
end
