FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 3..16)}
    email { Faker::Internet.email }
    city {Faker::Address.city }
  end
end
