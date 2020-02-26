FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(specifier: 3..16)}
    email { Faker::Internet.email }
    city {Faker::Address.city }
    firstname{ Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    password { Faker::Internet.password }
  end
end
