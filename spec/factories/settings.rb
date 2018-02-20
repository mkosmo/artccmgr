# frozen_string_literal: true

FactoryBot.define do
  factory :setting do
    key { Faker::Name.unique.first_name }
  end
end
