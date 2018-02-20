# frozen_string_literal: true

require "rails_helper"

RSpec.describe Atc::Position, type: :model do
  it "has a valid factory" do
    expect(build(:atc_position)).to be_valid
  end

  let(:position) { build(:atc_position) }

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(position).to validate_presence_of(:callsign) }
    it { expect(position).to validate_presence_of(:callsign_prefix) }
    it { expect(position).to validate_presence_of(:callsign_suffix) }
    it { expect(position).to validate_presence_of(:frequency) }
    it { expect(position).to validate_presence_of(:sortorder) }

    # Format validations
    it { expect(position).to_not allow_value("").for(:callsign) }
    it { expect(position).to_not allow_value("").for(:callsign_prefix) }
    it { expect(position).to_not allow_value("").for(:callsign_suffix) }
    it { expect(position).to_not allow_value("").for(:sortorder) }
    ["DEL", "GND", "TWR", "APP", "DEP", "CTR", "FSS"].each do |suffix|
      it { expect(position).to allow_value(suffix).for(:callsign_suffix) }
    end
    it { expect(position).to_not allow_value("ABC").for(:callsign_suffix) }

    # Inclusion/acceptance of values
    it { expect(position).to validate_length_of(:callsign_prefix).is_equal_to(3) }
    it { expect(position).to validate_length_of(:callsign_suffix).is_equal_to(3) }
    it { expect(position).to validate_length_of(:sector_id).is_at_most(3) }

    # Frequency Validations
    it { expect(position).to_not allow_value("").for(:frequency) }
    it { expect(position).to_not allow_value(nil).for(:frequency) }
    it { expect(position).to_not allow_value(110.0).for(:frequency) }
    it { expect(position).to_not allow_value(119.998).for(:frequency) }
    it { expect(position).to allow_value(199.998).for(:frequency) }
    it { expect(position).to allow_value(121.5).for(:frequency) }
    it { expect(position).to allow_value(123.05).for(:frequency) }
  end

end
