# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::Type, type: :model do
  it "has a valid factory" do
    expect(build(:training_type)).to be_valid
  end

  let(:type) { build(:training_type) }

  describe "ActiveRecord associations" do
    it { expect(type).to have_many(:sessions) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(type).to validate_presence_of(:name) }

    # Format validations

    # Inclusion/acceptance of values
    it { expect(type).to_not allow_value("").for(:name) }
    it { expect(type).to validate_uniqueness_of(:name).case_insensitive }
  end
  # describe 'ActiveRecord validations'

  describe "#to_s" do
    it "returns the name of the Training Type object" do
      expect(type.to_s).to eq type.name
    end
  end
end
