Fabricator(:wallsticker) do
  artist!
  title 'Pithy Title'
  source_image { File.open(File.join(Rails.root, 'spec', 'support', 'images', 'wallstickers', 'trip1_vector_1.jpg')) }
end
