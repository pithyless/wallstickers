Fabricator(:wallsticker_variant) do
  wallsticker!
  buyer! { Fabricate(:user) }
  color     "e3e3e3"
  width_cm  "40"
  height_cm "125"
  price_pln "31"
end
