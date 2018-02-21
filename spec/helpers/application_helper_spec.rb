# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do

  describe "#facility_ident" do
    it "returns the configured Setting for the facility identifier" do
      expect(helper.facility_ident).to eq Setting.facility["ident"]
    end
  end

  describe "#facility_name" do
    it "returns the configured Setting for the facility name" do
      expect(helper.facility_name).to eq Setting.facility["name"]
    end
  end

  describe "#facility_slogan" do
    it "returns the configured Setting for the facility slogan" do
      expect(helper.facility_slogan).to eq Setting.facility["slogan"]
    end
  end

end
