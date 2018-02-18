# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::Note, type: :model do
  it "has a valid factory" do
    expect(build(:training_note)).to be_valid
  end

  let(:note) { build(:training_note) }

  describe "ActiveRecord associations" do
    it { expect(note).to belong_to(:user) }
    it { expect(note).to belong_to(:instructor) }
    it { expect(note).to belong_to(:session) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(note).to validate_presence_of(:user) }
    it { expect(note).to validate_presence_of(:instructor) }

    # Format validations

    # Inclusion/acceptance of values
  end
  # describe 'ActiveRecord validations'

  describe "#comment_present" do
    it "is invalid if neither a comment or staff comment is present" do
      training_note = build(:training_note, comment: nil, staff_comment: nil)
      expect(training_note).to_not be_valid
    end

    it "is valid if a comment is present without a staff comment" do
      training_note = build(:training_note, :student_only_comment)
      expect(training_note).to be_valid
    end

    it "is valid if a staff comment exists without a comment" do
      training_note = build(:training_note, :staff_only_comment)
      expect(training_note).to be_valid
    end
  end

  describe "#student_feedback" do
    it "is invalid if a session is tied to the note without a comment" do
      training_note = build(:training_note, :with_session, comment: nil)
      expect(training_note).to_not be_valid
    end

    it "is invalid if a session is tied to the note and only a staff comment present" do
      training_note = build(:training_note, :with_session, :staff_only_comment)
      expect(training_note).to_not be_valid
    end

    it "is valid if a session is tied to the note and a comment is present" do
      training_note = build(:training_note, :with_session, :student_only_comment)
      expect(training_note).to be_valid
    end

    it "is valid if a session is tied to the note and both comment fields are present" do
      training_note = build(:training_note,
                            :with_session, :staff_only_comment, :student_only_comment
      )
      expect(training_note).to be_valid
    end
  end
end
