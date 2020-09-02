FactoryBot.define do
  factory :appointment do
    doctor
    user
    description { Faker::Lorem.paragraph }
    appointment_date { Date.today.next_month }
    appointment_time { Time.now.strftime('%I:%M:%S') }
  end
end
