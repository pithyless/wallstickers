Fabricator(:user) do
  username { sequence(:username) { |i| "user#{i}" }}
  email { sequence(:email) { |i| "user#{i}@example.com" }}
  first_name { sequence(:first_name) { |i| "Bob#{i}" }}
  last_name { sequence(:last_name) { |i| "Smith#{i}" }}
  password 's3cr3t'
end
