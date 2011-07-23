module ViewHelper
  def add_wallsticker_to_cart(wallsticker)
    "#{wallsticker.url_path}/order"
  end
end