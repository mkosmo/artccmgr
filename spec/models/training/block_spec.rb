# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::Block, type: :model do
  it "has a valid factory" do
    expect(build(:training_block)).to be_valid
  end

  let(:block) { build(:training_block) }

  describe "ActiveRecord associations" do
    it { expect(block).to belong_to(:rating) }
    it { expect(block).to have_many(:users).through(:progress) }
    it { expect(block).to have_many(:sessions).through(:progress) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(block).to validate_presence_of(:name) }
    it { expect(block).to validate_presence_of(:order) }

    # Format validations
    it { expect(block).to_not allow_value("").for(:name) }
    it { expect(block).to_not allow_value("").for(:order) }

    # Inclusion/acceptance of values
    # it { expect(block).to validate_uniqueness_of(:order).scoped_to(:rating) }
  end
  # describe 'ActiveRecord validations'
end
