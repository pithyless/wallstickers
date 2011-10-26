Fabricator(:wallsticker) do
  artist!
  category!
  title 'Pithy Title'
  source_image { File.open(File.join(Rails.root, 'spec', 'support', 'images', 'wallstickers', 'trip1_vector_1.jpg')) }
  browse_image { File.open(File.join(Rails.root, 'spec', 'support', 'images', 'wallstickers', 'trip1_vector_1.jpg')) }
  # TODO: find out why this association is so slow!
  # sale_photos(:count => 1) { |wallsticker, i| Fabricate(:sale_photo, :wallsticker => wallsticker) }
end
