# frozen_string_literal: true

FactoryBot.define do
  factory :vatsim_region, class: "Vatsim::Region" do
    sequence(:name) { |n| "Region #{n}" }
    sequence(:shortname) { |s| "R#{s}" }
  end
end
