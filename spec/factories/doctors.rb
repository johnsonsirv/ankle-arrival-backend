FactoryBot.define do
  factory :doctor do
    firstname{ Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    city {Faker::Address.city }
    username { Faker::Internet.unique.username(specifier: 3..16)}
  end
end
