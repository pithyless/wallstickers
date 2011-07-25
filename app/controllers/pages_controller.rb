class PagesController < ApplicationController
  skip_before_filter :require_login, :only => [:home]

  def home
    @featured_wallstickers = Wallsticker.top_featured
  end
end
