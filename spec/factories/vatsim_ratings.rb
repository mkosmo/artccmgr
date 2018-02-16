# frozen_string_literal: true

FactoryBot.define do
  factory :vatsim_rating, class: "Vatsim::Rating" do
    sequence(:name) { |n| "Rating #{n}" }
    sequence(:vatsim_id) { |s| s + 12 }

    short_name { Faker::Name.unique.initials(3) }
  end
end
