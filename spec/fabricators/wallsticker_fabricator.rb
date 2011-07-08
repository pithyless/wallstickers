Fabricator(:wallsticker) do
  artist!
  title 'Pithy Title'
  source_image { File.open(File.join(Rails.root, 'spec', 'support', 'images', 'wallstickers', 'strus.png')) }
end
