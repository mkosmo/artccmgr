# frozen_string_literal: true

FactoryBot.define do
  factory :training_block, class: "Training::Block" do
    sequence(:name) { |x| "Training Block ##{x}" }
    sequence(:order) { |o| o }

    trait :assigned_to_rating do
      association :rating, factory: :vatsim_rating
    end
  end
end
