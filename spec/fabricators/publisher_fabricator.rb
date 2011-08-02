Fabricator(:publisher) do
  name "The Printing Office, Inc."
  printers(:count => 1) { |publisher, i| Fabricate(:printer, :publisher => publisher)}
end
