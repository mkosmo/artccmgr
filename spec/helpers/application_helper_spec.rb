# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeHelper, type: :helper do

  describe "#facility_ident" do
    it "returns the configured Setting for the facility identifier" do
      ident = "ZTS"
      Setting.create(key: :facility, value: { ident: ident })

      expect(helper.facility_ident).to eq ident
    end
  end

  describe "#facility_name" do
    it "returns the configured Setting for the facility name" do
      name = "ARTCC Test"
      Setting.create(key: :facility, value: { name: name })

      expect(helper.facility_name).to eq name
    end
  end

  describe "#facility_slogan" do
    it "returns the configured Setting for the facility slogan" do
      slogan = "An awesome slogan."
      Setting.create(key: :facility, value: { slogan: slogan })

      expect(helper.facility_slogan).to eq slogan
    end
  end

end
