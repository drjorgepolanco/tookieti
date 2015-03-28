User.create!(first_name:            "Jorge",
             last_name:             "Polanco",
             email:                 "dr.jorgepolanco@gmail.com",
             password:              "worldtriculi",
             password_confirmation: "worldtriculi",
             admin:                 true)

99.times do |n|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email      = "example-#{n + 1}@mail.com"
  password   = "password"
  User.create!(first_name:            first_name,
               last_name:             last_name,
               email:                 email,
               password:              password,
               password_confirmation: password)
end