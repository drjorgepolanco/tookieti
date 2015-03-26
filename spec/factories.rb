FactoryGirl.define do
  factory :user do
    first_name            "Julito"
    last_name             "Triculi"
    email                 "triculito@mail.com"
    password_digest       User.digest('password')
  end
end
