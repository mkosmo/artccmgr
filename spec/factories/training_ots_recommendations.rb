# frozen_string_literal: true

FactoryBot.define do
  factory :training_ots_recommendation, class: "Training::Ots::Recommendation" do
    association :user,       factory: :user
    association :instructor, factory: :user
    association :rating,     factory: :vatsim_rating
  end
end
