# frozen_string_literal: true

FactoryBot.define do
  factory :training_ots_result, class: "Training::Ots::Result" do
    association :recommendation, factory: :training_ots_recommendation
    association :instructor,     factory: :user

    comments { "Comments on this OTS experience" }
  end
end
