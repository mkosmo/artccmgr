# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    association :rating, factory: :vatsim_rating

    sequence(:cid) { |c| c }

    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
    reg_date   { Time.now.utc }

    trait :controller do
      association :facility, factory: :vatsim_facility
    end
  end
end
