#
# Categories
#
['For Him', 'For Her', 'Kitchen', 'Den', 'Bedroom'].each do |name|
  c = Category.find_or_initialize_by_name(name)
  c.save!
end
