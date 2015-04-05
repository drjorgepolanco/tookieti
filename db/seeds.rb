User.create!(first_name:            "Jorge",
             last_name:             "Polanco",
             email:                 "dr.jorgepolanco@gmail.com",
             password:              "worldtriculi",
             password_confirmation: "worldtriculi",
             admin:                 true,
             activated:             true,
             activated_at:          Time.zone.now)

99.times do |n|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email      = "example-#{n + 1}@mail.com"
  password   = "password"
  User.create!(first_name:            first_name,
               last_name:             last_name,
               email:                 email,
               password:              password,
               password_confirmation: password,
               activated:             true,
               activated_at:          Time.zone.now)
end

users = User.order(:created_at).take(6)

50.times do
  title       = "#{Faker::Lorem.word} #{Faker::Lorem.word}"
  description = Faker::Lorem.sentence
  steps       = Faker::Lorem.sentence(3)
  # prep_time   = Faker::Number.digit
  picture     = File.open(File.join(Rails.root, 'spec/fixtures/files/recipe.jpg'))
  users.each do |user|
    user.recipes.create!(title:       title,
                         description: description,
                         steps:       steps,
                         # prep_time:   prep_time,
                         picture:     picture)
  end
end