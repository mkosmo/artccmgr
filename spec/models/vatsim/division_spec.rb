# frozen_string_literal: true

require "rails_helper"

RSpec.describe Vatsim::Division, type: :model do
  it "has a valid factory" do
    expect(build(:vatsim_division)).to be_valid
  end

  let(:division) { build(:vatsim_division) }

  describe "ActiveRecord associations" do
    it { expect(division).to belong_to(:region) }
    it { expect(division).to have_many(:facilities).dependent(:destroy) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(division).to validate_presence_of(:name) }
    it { expect(division).to validate_presence_of(:shortname) }

    # Format validations
    it { expect(division).to_not allow_value("").for(:name) }
    it { expect(division).to_not allow_value("").for(:shortname) }

    # Inclusion/acceptance of values
    it { expect(division).to validate_uniqueness_of(:name).case_insensitive }
    it { expect(division).to validate_uniqueness_of(:shortname).case_insensitive }
  end
  # describe 'ActiveRecord validations'
end
