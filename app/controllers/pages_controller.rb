class PagesController < ApplicationController
  skip_before_filter :require_login

  def home
    @categories = Category.all
    @active_category = Category.find_by_slug!('kitchen')
    @featured_wallstickers = Wallsticker.top_featured
    @promoted_artist = Artist.find_by_username('krzysztof') # TODO
  end
end
