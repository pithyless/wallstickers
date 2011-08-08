Fabricator(:sale_photo) do
  image { File.open(File.join(Rails.root, 'spec', 'support', 'images', 'sales', 'trip2_product_1.jpg')) }
end
