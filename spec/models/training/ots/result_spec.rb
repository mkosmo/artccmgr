# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::Ots::Result, type: :model do
  it "has a valid factory" do
    expect(build(:training_ots_result)).to be_valid
  end

  let(:result) { build(:training_ots_result) }

  describe "ActiveRecord associations" do
    it { expect(result).to belong_to(:recommendation) }
    it { expect(result).to belong_to(:instructor) }
    it { expect(result).to belong_to(:session) }
    it { expect(result).to have_one(:user) }
    it { expect(result).to have_one(:rating) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(result).to validate_presence_of(:session) }

    # Format validations

    # Inclusion/acceptance of values
  end
  # describe 'ActiveRecord validations'
end
