# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::Progress, type: :model do
  it "has a valid factory" do
    expect(build(:training_progress)).to be_valid
  end

  let(:progress) { build(:training_progress) }

  describe "ActiveRecord associations" do
    it { expect(progress).to belong_to(:user) }
    it { expect(progress).to belong_to(:block) }
    it { expect(progress).to belong_to(:session) }
  end

  describe "ActiveRecord callbacks" do
    it { expect(progress).to callback(:set_started_at).after(:initialize) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(progress).to validate_presence_of(:started_at) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(progress).to_not allow_value(Time.now.utc - 1.minute).for(:completed_at) }
  end
  # describe 'ActiveRecord validations'

  describe "ActiveRecord scopes" do
    describe "#completed" do
      it "returns an array of completed training blocks" do
        create_list(:training_progress, 5, completed_at: Time.now.utc + 1.second)
        expect(Training::Progress.completed.count).to eq 5
      end
    end

    describe "#incomplete" do
      it "returns an array of incomplete training blocks" do
        create_list(:training_progress, 5)
        expect(Training::Progress.incomplete.count).to eq 5
      end
    end
  end

  describe "#completed?" do
    it "returns true when a completion date is set" do
      progression = build(:training_progress, completed_at: Time.now.utc)
      expect(progression.completed?).to eq true
    end

    it "returns false when a completion date is blank" do
      expect(build(:training_progress, completed_at: nil).completed?).to eq false
    end
  end

  describe "#set_started_at" do
    it "does not modify the start time if set" do
      time = Time.now.utc - 1.day
      progression = build(:training_progress, started_at: time)
      expect(progression.started_at).to eq time
    end

    it "sets the current time if nil" do
      expect(progress.started_at.class).to eq ActiveSupport::TimeWithZone
    end
  end
end
