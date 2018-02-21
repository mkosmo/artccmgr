# frozen_string_literal: true

require "rails_helper"

RSpec.describe Role, type: :model do
  it "has a valid factory" do
    expect(build(:role)).to be_valid
  end

  let(:role) { build(:role) }

  describe "ActiveRecord validations" do
    it { expect(role).to validate_presence_of(:name) }
    it { expect(role).to validate_uniqueness_of(:name).ignoring_case_sensitivity }
    it { expect(role).to_not allow_value("").for(:name) }
  end
end
