# frozen_string_literal: true

FactoryBot.define do
  factory :training_note, class: "Training::Note" do
    association :user
    association :instructor, factory: :user

    comment { Faker::Lorem.paragraph }

    trait :staff_only_comment do
      comment { nil }
      staff_comment { Faker::Lorem.paragraph }
    end

    trait :student_only_comment do
      comment { Faker::Lorem.paragraph }
      staff_comment { nil }
    end

    trait :with_session do
      association :session, factory: :training_session
    end
  end
end
