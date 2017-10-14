User.create!(username:  "Example User",
             email: "example@example.net")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  User.create!(username:  name,
               email: email)
end
