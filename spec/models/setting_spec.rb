require 'rails_helper'

RSpec.describe Setting, type: :model do
  it "has a valid factory" do
    expect(build(:setting)).to be_valid
  end

  let(:setting) { build(:setting) }

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(setting).to validate_presence_of(:key) }
  end
end
