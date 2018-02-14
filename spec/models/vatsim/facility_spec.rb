# frozen_string_literal: true

require "rails_helper"

RSpec.describe Vatsim::Facility, type: :model do
  it "has a valid factory" do
    expect(build(:vatsim_facility)).to be_valid
  end

  let(:facility) { build(:vatsim_facility) }

  describe "ActiveRecord associations" do
    it { expect(facility).to belong_to(:division) }
    # it { expect(facility).to have_many(:users).dependent(:destroy) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(facility).to validate_presence_of(:name) }
    it { expect(facility).to validate_presence_of(:shortname) }

    # Format validations
    it { expect(facility).to_not allow_value("").for(:name) }
    it { expect(facility).to_not allow_value("").for(:shortname) }

    # Inclusion/acceptance of values
    it { expect(facility).to validate_uniqueness_of(:name).case_insensitive }
    it { expect(facility).to validate_uniqueness_of(:shortname).case_insensitive }

    it { expect(facility).to validate_length_of(:shortname).is_at_most(4) }
  end
  # describe 'ActiveRecord validations'
end
