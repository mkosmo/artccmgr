# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::Session, type: :model do
  it "has a valid factory" do
    expect(build(:training_session)).to be_valid
  end

  let(:session) { build(:training_session) }

  describe "ActiveRecord associations" do
    it { expect(session).to belong_to(:user) }
    it { expect(session).to belong_to(:instructor) }
    it { expect(session).to belong_to(:type) }

    it { expect(session).to have_one(:ots) }
    it { expect(session).to have_one(:progress) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(session).to validate_presence_of(:user) }
    it { expect(session).to validate_presence_of(:instructor) }
    it { expect(session).to validate_presence_of(:type) }
    it { expect(session).to validate_presence_of(:started_at) }
    it { expect(session).to validate_presence_of(:ended_at) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(session).to_not allow_value("").for(:started_at) }
    it { expect(session).to_not allow_value("").for(:ended_at) }

    it { expect(session).to_not allow_value(Time.now.utc - 1.minute).for(:ended_at) }
    it { expect(session).to accept_nested_attributes_for(:notes) }
  end
  # describe 'ActiveRecord validations'

  describe "#instructor_not_student" do
    it "is invalid if the student is the instructor" do
      student = create(:user)
      expect(build(:training_session, user: student, instructor: student)).to_not be_valid
    end
  end

  describe "#ots?" do
    it "returns true if this session represents an OTS" do
      session = create(:training_ots_result).session
      expect(session.ots?).to eq true
    end

    it "returns false if this session is not an OTS" do
      session = build(:training_session)
      expect(session.ots?).to eq false
    end
  end

  describe "#note_exists" do
    it "is invalid if no notes exist for the session" do
      training_session = build :training_session, notes: []
      expect(training_session).to_not be_valid
    end

    it "is valid if at least one note exists for the session" do
      note = build(:training_note)
      training_session = build :training_session, notes: [note]
      expect(training_session).to be_valid
    end
  end
end
