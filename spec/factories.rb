FactoryGirl.define do
  factory :user do
    first_name            "Julito"
    last_name             "Triculi"
    email                 "triculito@mail.com"
    password_digest       User.digest('password')
    activated             true
    activated_at          Time.zone.now
  end
end
