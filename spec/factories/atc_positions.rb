# frozen_string_literal: true

FactoryBot.define do
  factory :atc_position, class: "Atc::Position" do

    t_name = Faker::Name.unique.first_name

    name { t_name }
    callsign { "#{t_name} Radio" }
    callsign_prefix { Faker::Name.unique.initials }
    sequence(:sector_id) { |n| "#{n}" }
    callsign_suffix { ["DEL", "GND", "TWR", "APP", "DEP", "CTR", "FSS"].sample }
    frequency { Faker::Number.decimal(3, 3) }
    designated { Faker::Boolean.boolean }
    primary { Faker::Boolean.boolean }
    sequence(:sortorder) { |n| "#{n}" }
    visible { Faker::Boolean.boolean }

  end
end
