# frozen_string_literal: true

FactoryBot.define do
  factory :training_ots_result, class: "Training::Ots::Result" do
    association :recommendation, factory: :training_ots_recommendation
    association :instructor,     factory: :user
    association :session,        factory: :training_session
  end
end
