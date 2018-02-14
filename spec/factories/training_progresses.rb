# frozen_string_literal: true

FactoryBot.define do
  factory :training_progress, class: "Training::Progress" do
    association :user
    association :block, factory: :training_block

    started_at { Time.now.utc }
  end
end
