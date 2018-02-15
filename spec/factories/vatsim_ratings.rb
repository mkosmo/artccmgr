# frozen_string_literal: true

FactoryBot.define do
  factory :vatsim_rating, class: "Vatsim::Rating" do
    sequence(:name) { |n| "Rating #{n}" }
    sequence(:short_name) { |s| "R#{s}" }
    sequence(:vatsim_id) { |s| "#{s}" }
  end
end
