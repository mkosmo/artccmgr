FactoryBot.define do
  factory :setting do
    key { Faker::Name.unique.first_name }
  end
end
