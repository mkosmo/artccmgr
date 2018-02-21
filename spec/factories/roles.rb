# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { Faker::Name.unique.first_name }
  end
end
