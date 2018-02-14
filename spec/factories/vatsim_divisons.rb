# frozen_string_literal: true

FactoryBot.define do
  factory :vatsim_division, class: "Vatsim::Division" do
    association :region, factory: :vatsim_region

    sequence(:name) { |n| "Division #{n}" }
    sequence(:short_name) { |s| "D#{s}" }
  end
end
