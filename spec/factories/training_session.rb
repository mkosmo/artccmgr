# frozen_string_literal: true

FactoryBot.define do
  factory :training_session, class: "Training::Session" do
    association :user
    association :instructor, factory: :user
    association :type,       factory: :training_type

    started_at { Time.now.utc }
    ended_at   { Time.now.utc + 1.minute }

    notes { build_list :training_note, 1 }
  end
end
