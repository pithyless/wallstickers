class WallstickersController < ApplicationController
  def index
    @wallstickers = Wallsticker.order('created_at desc')
  end

  def create
    # TODO: redirect if current_user.artist.nil?
    @wallsticker = current_user.artist.wallstickers.build(params[:wallsticker])
    if @wallsticker.save
      redirect_to @wallsticker
    else
      render :action => 'new'
    end
  end

  def new
    @wallsticker = current_user.artist.wallstickers.build()
  end
end
