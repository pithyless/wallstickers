class CategoriesController < ApplicationController
  skip_before_filter :require_login

  def browse
    @categories = Category.all
    @active_category = Category.find_by_slug!(params[:id])
    @wallstickers = @active_category.wallstickers
  end
end
