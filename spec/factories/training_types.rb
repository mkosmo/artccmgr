# frozen_string_literal: true

FactoryBot.define do
  factory :training_type, class: "Training::Type" do
    sequence(:name) { |n| "Training Type #{n}" }
  end
end
