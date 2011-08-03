class WallstickersController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :gallery, :show]

  def index
    @wallstickers = Wallsticker.order('created_at desc')
  end

  def gallery
    @artist = Artist.find_by_username!(params[:artist])
    @wallstickers = @artist.wallstickers.order('created_at desc')
  end

  def new
    @artist = Artist.find_by_username!(params[:artist])
    @wallsticker = @artist.wallstickers.build()
    authorize! :create, @wallsticker
  end

  def create
    @artist = Artist.find_by_username!(params[:artist])
    @wallsticker = @artist.wallstickers.build(params[:wallsticker])
    authorize! :create, @wallsticker

    if @wallsticker.save
      redirect_to show_wallsticker_path(@wallsticker)
    else
      render :action => 'new'
    end
  end

  def show
    @wallsticker = Wallsticker.from_param!(params[:artist_title])
    authorize! :read, @wallsticker

    @artist = @wallsticker.artist
    @variant = WallstickerVariant.new
  end

  def add_to_cart
    @wallsticker = Wallsticker.from_param!(params[:artist_title])
    @artist = @wallsticker.artist

    width, height, price = [40, 125, 31] # TODO

    @variant = WallstickerVariant.new
    @variant.wallsticker = @wallsticker
    @variant.color = params[:wallsticker_variant][:color]
    @variant.width_cm = width
    @variant.height_cm = height
    @variant.price_pln = price
    @variant.save!

    @item = current_user.cart.items.build(:wallsticker_variant => @variant)

    if @item.save
      redirect_to shopping_cart_path
    else
      render :action => 'show'
    end
  end
end
