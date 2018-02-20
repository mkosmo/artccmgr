# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeHelper, type: :helper do

  describe "#site_title" do
    it "returns the configured Setting for the frontend title" do
      title = "ARTCC Test"
      Setting.create(key: :frontend, value: { title: title })

      expect(helper.site_title).to eq title
    end
  end

  describe "#site_slogan" do
    it "returns the configured Setting for the frontend slogan" do
      slogan = "An awesome slogan."
      Setting.create(key: :frontend, value: { slogan: slogan })

      expect(helper.site_slogan).to eq slogan
    end
  end

end
