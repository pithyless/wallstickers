class PagesController < ApplicationController
  skip_before_filter :require_login, :only => [:home]

  def home
    @active_category = 'kitchen'
    @featured_wallstickers = Wallsticker.top_featured
  end
end
