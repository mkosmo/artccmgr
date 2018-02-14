# frozen_string_literal: true

require "rails_helper"

RSpec.describe Vatsim::Region, type: :model do
  it "has a valid factory" do
    expect(build(:vatsim_region)).to be_valid
  end

  let(:region) { build(:vatsim_region) }

  describe "ActiveRecord associations" do
    it { expect(region).to have_many(:divisions).dependent(:destroy) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(region).to validate_presence_of(:name) }
    it { expect(region).to validate_presence_of(:short_name) }

    # Format validations
    it { expect(region).to_not allow_value("").for(:name) }
    it { expect(region).to_not allow_value("").for(:short_name) }

    # Inclusion/acceptance of values
    it { expect(region).to validate_uniqueness_of(:name).case_insensitive }
    it { expect(region).to validate_uniqueness_of(:short_name).case_insensitive }
  end
  # describe 'ActiveRecord validations'
end
